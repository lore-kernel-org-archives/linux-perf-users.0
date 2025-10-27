Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021081.outbound.protection.outlook.com [52.101.52.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B21DFFC;
	Mon, 27 Oct 2025 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761532149; cv=fail; b=It/B8jbOU77NxdYtpfKMC7INySCj0ChbnFDNpz9rCzogU+iUvrf9TTA185AmMxFIoOVNYx4D07a+185uVmUXxim1ogD6LGDlRgZyJhKvBCK0CJe+EO3K9MqMHe16HemQqT0gcZdw82huQLyV9eoq9Hl0r0QzhJz7kkVHAmS53pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761532149; c=relaxed/simple;
	bh=GO5s/u57a8PuSPf/8hFeBlVk55nly8dWexZLdBFfMbk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p+cRjZgJTZY3nc5nbYYTEQjUfKlGKE8yx3kkfSR58m/9oeZevXugHc2xCYKElMk05+K43jXNK8MBRxs9EBta2hYTipdY1EZFuG2YOUZfYS2CS6xvIc69Q0sJN5VUWJdis7mgJ6dkVES8NbsaY6uCAPKahUkUxdSHOGSznthz9T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cHQ/8Kqr; arc=fail smtp.client-ip=52.101.52.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cHQ/8Kqr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjANRiSEwLZYEJiqEjU7Lcm8KqMZCwVTf2ctovWA4Ti3gBMicPMFEj9IGyDpJaozyy14KicKJpzx15HSQPCAN+FhXKjYRQutGxluNiUIH3xT6O6nZsUwmz2cE1Mik0Yn4JAC249seF7wuHSZZowyF8ThqmNjrFMrZfiQAJq9cFE8S7LRepAflUL8f8nHgrYFoWRXpHZn5zkKC7Ue5bdwRz2bBNfFrJfO79a/1MCEC4IyZAE5jexm0Y8CT6d9vxzBr91/crgqpEWVw3endvvc0mUJkyZIUOMp/kwgernFsD8eZnMYcppnqpBhaEeLaOLP32HV9G57N4TNkzdTTh/4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLJpkSqrk5b/utpx0e0Ajo8RW0jA+yqTqGBb0XK9HaQ=;
 b=x7NpSEkYXjetp80BV/ThKEUNGN+jaIsJCpRfF+lIltO2MipCCvHofvDdRRBq8YLSheBAAr94s1aV9UFXa4qq2IAOPyOWDn/+j09BTvEWJ1Ik881RlKmGWLd2HccVCbxHWinLKjnZsikWoNUOPoQmu1H5JWb0vv/cpwCQ4VUl1W0pRX2D+O3rSBAdJfVrgl5VRW2ix2RqsDdq0FdQCg9bzfgN8FD/iSQvHWLTEbv+EmtFa5IMWK4LLswD5aRaIcp/NUusCZptKuOKtHYbTbbvkgFctiDXGgDvWmHPgAUTcwFTkY+tUOjZ+9gg2Vfanh+oSGwIIkQifaQCnbdtS8Pang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLJpkSqrk5b/utpx0e0Ajo8RW0jA+yqTqGBb0XK9HaQ=;
 b=cHQ/8KqrBKmQgB/M8tqCZTQ2ehExyZM3ZNuYYBO1vVeg3LS7+8ksM3/MtKm6MJ3URRo0Q/Gsl5BJp38LfkMwtBEfbC+AKIHV4Xhw0LSirV/LN0aEmZLkRLaWAq7WoTtupz1/hZ+PcYUcrLmx49sZspR9m09+jDv6aAXFrBJqfTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DM4PR01MB7859.prod.exchangelabs.com (2603:10b6:8:6d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.17; Mon, 27 Oct 2025 02:29:00 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.9228.016; Mon, 27 Oct 2025
 02:28:59 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: patches@amperecomputing.com,
	cl@linux.com,
	Shubhang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] perf: arm-spe: set the correct interval for PMSIRR_EL1
Date: Mon, 27 Oct 2025 10:24:45 +0800
Message-Id: <20251027022445.892607-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0036.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::15) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DM4PR01MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: cc94b307-dcf8-4257-cd30-08de150095fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qYJcXWd05TeZ9iNH6IAtIYFEBjcgdasQZWTDKHFQNJJBQIHrMQtZ24Ck2k/V?=
 =?us-ascii?Q?PHbRCmWakeRI4IEvA9TrU1z5QRNQnnUDeC3HvZdAPi+wJJUG58MuED+R5s+i?=
 =?us-ascii?Q?0FqiTQPlwSACzd67Nqk1Eu1WTnuEAtLtxgWhtyoziXxEkR9+31bPogsm1ZpI?=
 =?us-ascii?Q?Y0rAPnctUW8+xCPopJHGbzT+RhiXVuT3K0E6Qx/0ROIB7iPwa0HNEYxihCUh?=
 =?us-ascii?Q?jtVZrDGl6GObYWUjGI2Gcf235UNeP0ZtlBuqyfzxPhTjQejoQq2g0rqrej2r?=
 =?us-ascii?Q?GJ4BJTv/3nGDl7rRYfRUuErXpY5AE9RPvZOmjat6XX0Rj7MY9QY8Q4DfY8SU?=
 =?us-ascii?Q?Q068wRWArJtq03MJ+YXnELi7cWgUjdNoIErmfIYA4O9Vj8RMCDQVSzE1sVKK?=
 =?us-ascii?Q?BDZnoS3Ssp0j/LDdE43zZ/6XP6N7SDU/Uu2TcV5b6+eVZgGXzxSCD3o7k0iM?=
 =?us-ascii?Q?P/abrYjwlEi0VtMaOk82kztMRlQE3vVHQMiiJmv9amDzFHmzpPDnvm8uttfm?=
 =?us-ascii?Q?r3RPtb9FG2FmcbbB2an8LuGw0w6jZTeGEqKip8PyS/QLA9s3OTLedEv9qMCE?=
 =?us-ascii?Q?2wpfE5EP3M+kZa0KNYGi3FMg5iuo3ArkBEYiliSOTwxEk2jjtbtouyMp7/I3?=
 =?us-ascii?Q?bXHq6pZWaBs/HwmFecQaWkuuNFIUeH15E6jRkaM4M9+/rm08CDefQRSYKSu0?=
 =?us-ascii?Q?7MfJSv4jd4QNUhHtjGfk7JicYPQCpZJCp9VgDnO5iU7/mbkXEzw9oaslHj9r?=
 =?us-ascii?Q?EnG54j1dviXRcqjoA+YcVINSFwiqEFe0egW/z8pbJUJz643TnNIq1JCQKM4U?=
 =?us-ascii?Q?EaBH/aUMn36j5QNQvZXQEinrk14+smQAAeMqWqznoqu+OgzGHymucP8xUh3C?=
 =?us-ascii?Q?Sq6mkn3NcUENK8j/gFjnMvE5cipPHVa1xJeQxA4NoMML8+c4nOAsKDQk9z82?=
 =?us-ascii?Q?lkDYczD/PCeYUrfUQQyN1ufbcADRBvN0t0oEdMa83aEQ9LlTjq6Zs/y5Kd1G?=
 =?us-ascii?Q?+MXzXpm6UK7YRSI14AStv/nDYlz0iSxX7e3scj5S6KFNofj6/DsMMOViWaje?=
 =?us-ascii?Q?opCXthh4BmEwL3HNf09DPq3r+T3I3TyRv+L7TLAbwd+iHHkbm7ZsBDpOORVc?=
 =?us-ascii?Q?m0DxD+7pCgPlQz55SF/GNWmDnyu6pOc4G/sojo3qcAp2GRhIMS3Epuv4RqaN?=
 =?us-ascii?Q?pTf2Y9av+bIthhwlzcYfr47oO5N4JTu0un4p8Uyt0Zcbk+JocuXhG1pE3jHm?=
 =?us-ascii?Q?f2rgrHfn70LFJOP+b/8ZW40xOKR2D/tO670xhUlk+CkmEf8ZlD2YojqvUdG2?=
 =?us-ascii?Q?euvbcEQM9W/79h/D7IK05EoaqKYr9isj/afj/grMWk0+uSFkzLWGL/DrQwF7?=
 =?us-ascii?Q?CL9WK3xrJbpMzG7jmRSJyzFNaqCFlPGFmTzTavivfLu+2kQ6nCHT/kmpEBQo?=
 =?us-ascii?Q?OG/JW1ApXIVo9hKEBT85Z3DgE3zdZI7zVufUS9+2xKYFRiPBq4s+uwW/pJlm?=
 =?us-ascii?Q?iVaxxPTAD0skZu6+w3Ynb7eCkHoMDC9wlSjO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VYcyVurDsb9JWn7dtSGcBonboekWE63t64TVNftmHhoPFfq/874zEQMm07xw?=
 =?us-ascii?Q?vGsD6xtqex7kfiNgrvt/hrS/xHxaLOjX+IdIYW9i3IQyVsFA28KoqLLAZ3y2?=
 =?us-ascii?Q?NiLHJuUBN1giea9r0+MrNp6NwLpPPv4Pyw4vq7uwexsJdc6blOa1VhpHaSNQ?=
 =?us-ascii?Q?CZOS6awRkTj+dcSv51ayjCk6wJc43+UxwDEC/Ca+3k7QDcJGcIOd73f6co7o?=
 =?us-ascii?Q?gquWtI9JEM1VPjtt2rzDehT/IjR/Hr2hdp8E1BsWCePcgENR69+WAg0O2tPC?=
 =?us-ascii?Q?FJMIIb441SL99pm538ogPpvl8XemxmP3bDBUrJaClNTwLwgoxRFnv1HgbNYQ?=
 =?us-ascii?Q?nadFIQAp7SrfdqbZOaguWvRo+eRQ5ZBa9IWq1YwyZup0IOV/8dimYqPgvOtl?=
 =?us-ascii?Q?Nu7sMYyVO+Oqvt8EiYHdOujLhDzYRbnA3/Nj07VZwW+ZGF98z8itWsGeXKGI?=
 =?us-ascii?Q?6eJsR0PZk1LUpz0C0Cy8R5YXLECsGniV1TCdW3ZJcRD7/HQiNLNlRWeUaYT5?=
 =?us-ascii?Q?SItN2/w94KpA5r28jIOHaPq8bqXMI+RFH2p2mSZlf6oYhVFMabANbpbGNPoh?=
 =?us-ascii?Q?90EaTDtG2VLwmYOmzKkN3g3y+pnr6qj+O/pTVNEdBUdAcO0ib/GF6ojZ6wUF?=
 =?us-ascii?Q?lyCo9KHNcV12e+l2hDVhdX9p7mm5HFqglmNlPd4Y5Qqkf+a4FySt97anQMB7?=
 =?us-ascii?Q?khoatLvzrxv6BFJIyGBcx22zH117Qr9XRuQkn5lQsWnxAujeGLZk9/lpx+6M?=
 =?us-ascii?Q?5gOfMVpZPNpDrzrFoGJBIXm5MvWudOILDB4lTykiaGU8JZaBbjnBCGJlkeuV?=
 =?us-ascii?Q?9BxcsGvUg0MR+wC2V6kbi8I9zigshwEQoBLKppaKeZ0k1Eh0jv9mzRLmqoKG?=
 =?us-ascii?Q?pK69EsbWCJPABzd1pKpAdCl1MWCnTFCy61TLzvwRxkXOOkiXwUD3fY886a2v?=
 =?us-ascii?Q?cO8NvX4Sp+AAT1QYhFSbHI/dFYzQwuIkRueIg9UMCdYOjyZ0f4h+CQZ/JBSv?=
 =?us-ascii?Q?NsdzjHnKqd4avrVfF0DPDMhiHnc0czZxzGphBmDs5hJBBdJLCmssC4DaSRh5?=
 =?us-ascii?Q?6kfEUU0gtHR9kWVJLyDg29n5aGgdFhUcNSYCqM80wPXYuD5OC4FOdG7nB/rt?=
 =?us-ascii?Q?I9a7HBB0aCBf8/vG7sIQgAW8F1XPEUfyIAptKvPOe3bMF7Cb8qRQVXjXLMJJ?=
 =?us-ascii?Q?6RaAIE/dz7SkbEjgYPEUadqFQkbDdnXY1QmKWHl0TyhqI5ARS0u38XPdEfFW?=
 =?us-ascii?Q?JV2nsY6oCWNMG5l+NQDz1ws77Qlg6ljWwFc7U3HmaPHbFcsPz6vGn5B8LEDy?=
 =?us-ascii?Q?XI5Cjn26apOtKEU7LOrP4Tm9vzchItUmwixWxpFRsYz1bbVj2gEpsWRyG6Io?=
 =?us-ascii?Q?4CiQ8WOuqVbYoEsyRJDrq4UN0mTHCaHgJ25B96SXZgA4nNpohViCUzE31QGd?=
 =?us-ascii?Q?RoxTVn0iFCRggZh/dt1UZ1yfOcn0yw/6vFs/64w7Y94+CZ+WF5/kNJMLXi3t?=
 =?us-ascii?Q?2El1aIcG9B+nxbF6iQC4RdioiS4uWq9/hcL1YvkBSjRuzGbgslbgPnI3X5QJ?=
 =?us-ascii?Q?lcB8IxKTHEriy7ubOHSU9ByWvmjWLJ1OkDq/qnaZYUW7dzt7mP7VYmMhZ4Zi?=
 =?us-ascii?Q?P906S+3Hf5JmG61MKAnB7ts=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc94b307-dcf8-4257-cd30-08de150095fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:28:59.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hajnr06c6BuCHHcTaEzsF2k9ySAwLl5293ww5SWsbUB7l9Aagc6vNMejnOGS1/CRhliC/jidOKekz10y5Ifp8aDWK5ZYa0IQQWthgFikZvlhZA3ZwSDi4kTpUggz1X4x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7859

From the spec, the "interval" value for PMSIRR_EL1 is in the [31, 8] bits.
Current code does not set it correctly.

This patch fixes it.

Fixes: d5d9696b03808 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 drivers/perf/arm_spe_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645fedda..d424721b79ee 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -400,7 +400,7 @@ static u64 arm_spe_event_to_pmsirr(struct perf_event *event)
 	arm_spe_event_sanitise_period(event);
 
 	reg |= FIELD_PREP(PMSIRR_EL1_RND, ATTR_CFG_GET_FLD(attr, jitter));
-	reg |= event->hw.sample_period;
+	reg |= FIELD_PREP(PMSIRR_EL1_INTERVAL, event->hw.sample_period);
 
 	return reg;
 }
-- 
2.40.1

