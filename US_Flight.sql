/*1.	Quantitat de registres de la taula de vols*/

SELECT COUNT(flightID) AS TOTAL
FROM flights;

/*2.	Retard promig de sortida i arribada segons l’aeroport origen.*/

SELECT Origin, AVG (ArrDelay) AS promLLegadas, AVG (DepDelay) AS promSalidas 
FROM flights
GROUP BY Origin;

/* 3.Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen.
 A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files)*/
 
SELECT Origin, colYear AS year, colMonth AS mes, AVG(ArrDelay) AS promLLegada
FROM flights
GROUP BY Origin, colYear, colMonth
ORDER BY Origin ASC, colYear ASC, colMonth ASC;

/*4.Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen (mateixa consulta que abans i amb el mateix ordre).
 Però a més, ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat.*/
 
SELECT usairports.City AS City, flights.colYear AS year, flights.colMonth AS mes, AVG(flights.ArrDelay) AS promLLegada
FROM flights
INNER JOIN usairports ON flights.Origin = usairports.IATA
group by flights.Origin, flights.colYear, flights.colMonth
ORDER BY usairports.City ASC, flights.colYear ASC, flights.colMonth ASC;

/* 5.Les companyies amb més vols cancelats, per mesos i any. A més, han d’estar ordenades de forma que les companyies amb més cancel·lacions 
apareguin les primeres.*/

SELECT UniqueCarrier, colYear, colMonth, SUM(Cancelled) AS totalCancelados
FROM flights
GROUP BY UniqueCarrier, colYear, colMonth
HAVING SUM(Cancelled) > 0
ORDER BY totalCancelados DESC, colMonth ASC, colYear ASC;

/*6.	L’identificador dels 10 avions que més distància han recorregut fent vols.*/

SELECT   TailNum, SUM(Distance) AS totalDistance
FROM flights
GROUP BY TailNum
ORDER BY totalDistance DESC LIMIT 1,10;

/*7.Companyies amb el seu retard promig només d’aquelles les quals els seus
 vols arriben al seu destí amb un retràs promig major de 10 minuts.*/
 
SELECT UniqueCarrier, AVG(ArrDelay) AS promRetraso
FROM flights
GROUP BY UniqueCarrier
HAVING AVG(ArrDelay) > 10
ORDER BY promRetraso DESC;
