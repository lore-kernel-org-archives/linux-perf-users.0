Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013038.outbound.protection.outlook.com [52.101.127.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D878F2B;
	Tue,  2 Sep 2025 03:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784645; cv=fail; b=e1YTPugX4BGHPr6ZTlOtaUrjxge3vbO2fkYss10WOZyXx/WKOQNlTarIjMKmDlItm8/w83HKtCt2hjAiIO9yuaPDBt83euxoYCeAUeYa5eK3wPGBmfJ2fMcggyyM8QTSBrOt1R+9B3RxBYoQNwXRYLis5rUF4rOlzJXo/HFAVE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784645; c=relaxed/simple;
	bh=CtI4beuOVXTFupEzIWGyGIZq3WCVOOaN7jvVWtw51Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UHrahb3uMABWKGsH3n5rR9BAxsZlVwoL+aWndeORhPTzg3PICauCPywegOJTNZQAXtaiyGI9siFiD4g0R0ET7p/WgWzMKpcWkft+1GDmM5N5cY0oSil50gTWoaJTeJPJ1nfUtjysrhErr0EMAS8nd9SxiX8F77DEjHLqg5z5rmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aMW+cGec; arc=fail smtp.client-ip=52.101.127.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aMW+cGec"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM8Gn2njujKJ5oMC3JlGAUa7QymEyi5FGtR1w8xbGmmR3Uz3B6Lag/NI1UgDFRZ5npgIzQb895/+ctVzOc21ueaQvyr3d+PTArnHufbjC01Rsk3xN7G7GzguSplbicOvwn7K3vejTxiJJ83/LFEsm+oteWHEtuMO8t0uxOCDFnE0qUK4ct7QUdMjbSzrYxNMcCMqX+TvILduJQpuxMoy+haakP6UwChkxEeZaHrEwn+TLOVZjzSOOhdS7oQBtpp00WtxBZllekdOrsH7TJgvFOPUVYh7fvQjUXevNqtQLaYSsZxINjqH8egbb60gZjGpCel7q8XbNXR9h+QdqGuheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvaGk9rVLRrIEAPRhCrp5WV91bTFT9C+S5kmHS3ZXoU=;
 b=VJQXW0f+huZnxsIzOGstzGTaMuscG3YAgTwcrd4eECDcljSRLWRwIe0EfbeiHEFo02Rf9TGcJ9uQWaEThp8le8lr7xMrWSJ+6iA347H8W6pz9VhSZEDMr+Xrh4KWU1NU/XOceaaoKF1cgxJ+RNhxns0dbvELwbY4LiseA94SuJbFEINPGbKmn0Me8hR+FbPQ/5BHDAYhqiA1f8REIQXN9QU2ggWGG8gHjNsZh7xFuim5aP9A5pwH7+3WC0KMTLAJ7ZBoe9hB4/agxEIW/HTgS4eNJbCrtJMEvK8ODIsBOl7WDD4BxbpwWpLYFGEWnK6Z0seb+ZWkV/9VHA0AKiiO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvaGk9rVLRrIEAPRhCrp5WV91bTFT9C+S5kmHS3ZXoU=;
 b=aMW+cGecZuh16c52PwS0oPSeGss9lTY4KwtArsfV5aRmI5v8LxiQKtfyw9yl8hjclfylNI2LQKNmd9Np76s012xkJFnNbA6T9M3mBcDr65gKId7AdlXPqVI3Ccl0Z+hTJywG2MXeMESk1MKPuhQ4q+eXKriccllp2/GIbCTKlJzZDVEveIAmuxEf927njPNBzbWbl/lijYK7R3SIjAmuxpox5J66bWA7+FXOCb0GQRhlsp0Rjr27x6Zw/eZ005dzVI8XdA7mCLNdX3u+DuypN1qvJRhKzq0EYn3h9jfSF9kuaa8PfXu5y/bgtEnAiNi5/4LQ72X6Jdm6icGgOlwelw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com (2603:1096:820:146::7)
 by KL1PR06MB6649.apcprd06.prod.outlook.com (2603:1096:820:fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:43:58 +0000
Received: from KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5]) by KL1PR06MB7330.apcprd06.prod.outlook.com
 ([fe80::d1d3:916:af43:55f5%4]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 03:43:58 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] perf core: Replace offsetof() with struct_size()
Date: Tue,  2 Sep 2025 11:43:49 +0800
Message-Id: <20250902034349.601692-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To KL1PR06MB7330.apcprd06.prod.outlook.com
 (2603:1096:820:146::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7330:EE_|KL1PR06MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: db9b84c8-3e76-45b5-7638-08dde9d2f302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uVrr87NmkeHM0R2aRAM+zXCY7ZUN4DPkQnPXCg0TntRGw+nlJWfpq4diLS4G?=
 =?us-ascii?Q?tSq1HxLB7/XR1hwGFHllO3LU5A5+Lj7a3emeOIAJ7f1IV98aw3C/6QIDcw2z?=
 =?us-ascii?Q?9/5/0ytm5vBmCBSmTJIxvRHWeAvaLHrpk4bcGWHF0lb8KetQqeVYfVFYeRqF?=
 =?us-ascii?Q?gGSr+TrQ3nZ7aXBTlwSw4BGT5MULlt2jsAdGWskhXnl4WB/WvNdSkWJ1uEMS?=
 =?us-ascii?Q?TBKttdEqBrI04U1Qxm9AcHmObUH53s3DOj8GEvAZ4Rq19aS9nTyMZatY1lxe?=
 =?us-ascii?Q?bhcO4e10bwkvHIVLlutpbeDBolTQUtgR8cUwPCgEYOOZSIVyoPd1Z9rI6MP5?=
 =?us-ascii?Q?42b7TclY6gdbiT7Yau4P/mYREdzRA1rcWfGUcLS0XSdoo/IwTIj98PEx+kd8?=
 =?us-ascii?Q?6bYgoJQR4rQRS+r4kiNHHK5tM3WWfI8sX3xLsxgzarUSmZDCrKUBzhpuUw2V?=
 =?us-ascii?Q?DOGHojEHjsA1ltqE57IwxcHXTTAdboyg7VQ1uCSImiGf7EqUbmkdW2UMPz2Z?=
 =?us-ascii?Q?bqotMhPKCxqZR8zfcr09Z7vuYT7V7NUj8L26NWVMMVGQdG7BEH9zg7Hik/D+?=
 =?us-ascii?Q?I+7vpKyFsNnkFCCVlz2GRN6wdokXWMsc/gaiaihceGAz2bkNIo9Jcr4JbzZN?=
 =?us-ascii?Q?vtiXeCnKbzeuTODnKqbxC//svG4EgsWOycNk7ZzXuJpn87y8yllUeqrU3VVz?=
 =?us-ascii?Q?712CKGxsS32S1fSVyw7c8f0LopDl876r8HxD34+b6isdRprrg9jEfHNHfMM4?=
 =?us-ascii?Q?acwEm/ZPsQTPfDJZZ0zM7SBojOa8cPjWgSUxALXKN1DGw+/aEok69TNsp54U?=
 =?us-ascii?Q?iG7p2nRTiu+R9BQXkpeIneEz4bpFg4qCwSZ9CudidGAlSmbcNP6DQjo7EvE3?=
 =?us-ascii?Q?aLpYqcr4glWDezrpCbi9vjYhXDkzYHZ/6Spj6EB+MdVW9Eku42zMFe+/Yg+B?=
 =?us-ascii?Q?d9Vowk4wv7Bto8wnKnY0lxBxJhi/kTEi5ZgwgXtdbrCcWlWpp4SYpogky0+O?=
 =?us-ascii?Q?gouXkZFeqBYaDAcotln2pexMV/6IZ3Iy8cP3FflG5DLSjGgk7Qof8wJLTOgD?=
 =?us-ascii?Q?bLUnePTYSc6r8xEceHvuwXJSv7mPeZI0VdueaPy8TbIQwWXrTd+ylIakTjtU?=
 =?us-ascii?Q?wnJPvMJJNUmb6tta6NyW0+kcXj0okjygrhx1RP4wEGvitffHCPTSCOGm0Uc+?=
 =?us-ascii?Q?FIEVEYwC9UEjGRmIyClspRMThAzmU4UssWZsXWamAlEkU7m1L+296CtkQrx5?=
 =?us-ascii?Q?a3WNMEyQyZKrt3aEvQsFA9HO8HgnECxbycc+41k/fT2eGv6qTWkBFkBV+bZ2?=
 =?us-ascii?Q?U9BgHxU9/mydRleJsM4DPThd4p2vQW9CZoDCUbnirPWZmgpWEr7eRmA8M8lW?=
 =?us-ascii?Q?aOtQ92E5ThYwrKa1wTXce+yC/A/Sj1j/eXdMNIVK2yupKxnm04RqvBa0r1jj?=
 =?us-ascii?Q?+vpXH6LfWlcSyd0GnLxpI3/CfWH0e4VpHJ4W6u3qnNFq2cx3Np+TDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7330.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/64f4Eo/zjiWnqTsjDpD9DXpZO97ieprMq110kSgas1hGeHijNcZi7fF0V8m?=
 =?us-ascii?Q?h/0xXGEO4kyMtwW3khGmFY7meHTGa5eAp70VWXIX4bWw/LsJJ+60pZABtG8o?=
 =?us-ascii?Q?xK4JmMZCkGujW1evtYxTBiNIaDCErzBiR9yCF1TABWyLHh5JeckdWa9pLhlb?=
 =?us-ascii?Q?LoewMC5Jhir62BYWAp3UCMj3/0LU/6m/AUKY+RX/IW6qMMCt525A4Ty/UAqm?=
 =?us-ascii?Q?SKD244H1XEGh8q/p3rf6z1mV8A7j9v5DGRJebC3JUHngWiAFLZiery9mZ+ml?=
 =?us-ascii?Q?aD03zD3Pn3aZHxfCvsCiMOFIWYVssPmPVPlAhHjDgJ+GBBbIOCZ/W/ZXFmlz?=
 =?us-ascii?Q?q3qcpVxne+spyHKWzeaZB8/kXyM7kGDOuBgJagZgV1Vp2aIjmL0rmVe4vdVJ?=
 =?us-ascii?Q?gGUFsBsM3Ssqyn7HVMj28c8trsBTKiqQrYNi8QxDMPHR2HXT1j7mj8CnAp5r?=
 =?us-ascii?Q?5iIGsAM+NuwDNrhwYvUi9J3Tliu4Hx7TBPBrPVovzzl/+OCM8Zs4++zeK8gw?=
 =?us-ascii?Q?uL6opveoOyfXVHKtFmKY4/549unPmw7doH61K8wnlCudZAkwBR2x3BbQhZ57?=
 =?us-ascii?Q?ld4UArBMLxN5Pci6H4nVq5n3NiE0f+R7EdlIOg19JKrfb6IaBkQsMrvrzKpK?=
 =?us-ascii?Q?TrXo+5cogHxmjHAbAg4bimGacQaiXUJ5gOUUzG6E048HllCxZ1pXsDUKw7Km?=
 =?us-ascii?Q?LNctt2RKTXR3Yvn8iy6G3pYGSLd9LOAURqeeOYv5tAfsF/0F6mtu8kqyEWJq?=
 =?us-ascii?Q?od3h9qYeOX5DMaCbvGUqfIcNDEWIFhlEjU5Ke4pYkiCjzasnhI3bPiDSMEwo?=
 =?us-ascii?Q?PWFG0YDzzob9g/5XzwAgU89cZQSsSCwU3Dp5w+zkb8L+xMf+VRM5/oe3xL5i?=
 =?us-ascii?Q?mJ9olYpMWH1ZxKXYJyIofFuJ01qMniyiR4yLGbc1dhKN5oGE8zePeRqtGy/D?=
 =?us-ascii?Q?Da1mrIPK4OpSuMnHe6g1mnPTwm+uZo5HcKRSVQQl/ErGkjnLyUumCBByN/v4?=
 =?us-ascii?Q?ykiaS+gPff8Eg5hyUsCGVDkB2DnXu2GnN8fIGLoSOy8Os7tePm6NP885T+sQ?=
 =?us-ascii?Q?zbY8XJwPYvxEF39OP4H0KKr3bk0GkW3FyCQq1E0v0VTLtATYXvAaIj4TCxmT?=
 =?us-ascii?Q?52sAZ8qWc2bdY7F2Bm8gnBIKL2esjRcQte4CHdtwN9+lSLv1WQ3R08R5kFVu?=
 =?us-ascii?Q?gr1AqIvKi28vQ+MJOYLSnWACYx6q0998p6QCoiOxAeDQQPNWa6W7Q3ei4Rdj?=
 =?us-ascii?Q?iltt1SSJ9TKZdW+CSKzTcAyJgPX5DhaoetH6bvjVsIHpbPrDlszhZH5iBIIX?=
 =?us-ascii?Q?RbHGlo92ujvaBRnoyTZmvKY3SBeYBACOeFGxk2FWhVFXK4g7dOOqj21Hi4A4?=
 =?us-ascii?Q?0Jv0FzC+Y5jQ6BcTiS/9xaYg24tTbQaSsNCyH4Sc1KPbi3iXlllEGlZtz21F?=
 =?us-ascii?Q?OPjwY5XcINxZLKfUQ9t/ApMn4fJXi38i6iZGtqPdDOoZPkJzGFTGCjc3OxNz?=
 =?us-ascii?Q?yENWl4bB7W4EwVDto/Lqju8WW/S7zAiR63c+ZQ+V1sDk+JJVdz7c/bpxdczv?=
 =?us-ascii?Q?1KvonPd5NH54phPlcs9gG7CPb1oU5W2DUHyrojxn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9b84c8-3e76-45b5-7638-08dde9d2f302
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7330.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:43:58.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/ZY2OAWKmMbrqjRF/mTE3nRhDBnTr9u2uuAo/hYfWdpDbdFk7kvwHCOdry95FjJQQ8BoZSDijq7u/iWXcRarg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6649

When dealing with structures containing flexible arrays, struct_size()
provides additional compile-time checks compared to offsetof(). This
enhances code robustness and reduces the risk of potential errors.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 kernel/events/callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 6c83ad674d01..0f88e44af664 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -80,7 +80,7 @@ static int alloc_callchain_buffers(void)
 	 * accessed from NMI. Use a temporary manual per cpu allocation
 	 * until that gets sorted out.
 	 */
-	size = offsetof(struct callchain_cpus_entries, cpu_entries[nr_cpu_ids]);
+	size = struct_size(entries, cpu_entries, nr_cpu_ids);
 
 	entries = kzalloc(size, GFP_KERNEL);
 	if (!entries)
-- 
2.34.1

