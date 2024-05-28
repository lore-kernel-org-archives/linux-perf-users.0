Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2083.outbound.protection.outlook.com [40.107.15.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28773501;
	Tue, 28 May 2024 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883049; cv=fail; b=XcSfw8igO8cKW33iEgqhaJ5oOCg95vmh4F9w4NGI3vQbimwQOSPJRwl65lEAQmpxYxXXvJzr0BcgpnPW6Uuj+2lRHd93KRhYLXzqtqkmx+/Z291tsvhxQkLgp/oBxeAhK3N+pQEVUyzypnIfQCdK8zk3wIsXZgNgC6766WwukAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883049; c=relaxed/simple;
	bh=igIMTu4ay+VDLqpOqBsAkvBWBG2qQgyFMEWBLXlxWHg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=J2wFzpxl6f4YMcvAB/NNuYhcHHIvA6+OM5fjAm4kfOqrA8VmOpEn7KGVSvoTLf6So2g7JV1imUQVm9pL6MHnbkrPi/sIfE3UaqMwpar5q/tSPuxgiT0KIGzxYVSeJkQPQNSBvYsEnxHeD8iaV6SXpl7Q6ebVztXYLavM8EwdLjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R30Wotmy; arc=fail smtp.client-ip=40.107.15.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R30Wotmy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4PwH/N3M224YLHzgr3WhBpO+tv1mFNcem8y1qjuB3Ru/PEhn1Zsv5rgYwkx64OllEqnSXNUlR4YGirW73mBr44Gu1kjkc6pczkWoE7LrxebbWWFxwjeb6lT+y/KUaMx4A7LtzN6pneyrZHv9e2jx+baKFjvevlrxCZ0Yg/1A3LzFhD/gmcpQQ69o0t1raW/ZsthStXK3uFkG0+SZf5mA4a7KyYG7tOBkmPmLFeebVpNesWON9okrohZpqdPrZbRiQq8UkzxQKpFjU7rm4p5Twx3IunFyxSUJCgCU1gYYXViWmQ5VY+BeRSce3TnnPIP47CTh37lE1z2v3s+uVrGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyC1VDFKR4qUiWGvH5MWjaPd4aXsYihuuy/K0qVlVnU=;
 b=m8tKgBtfBDLfpMkToCl9OzxuNdmoFGShTbEdmVpu9L8QyeNy6Pqh7GnVs2AkwyJzFtVCi4CxThQeo2fMfTD+avFCVclbPghTiJgzg8UT6UxrkaUDkoqzMCi3c0NRw4hFd66A7m0HF5k1XKEudM4voGnEyUa6NAVn5038aRGn6jwBW2K53Shm858CYAD+iBYlvBslyAlQBNzOfpyJV8GKYRUnOsuENdHT/M1N7cHqTCpGoC89Quf/CHPOtc1zhCVePLNj5Ml35wkIZO68TgzGrNlBgnLFLBo5CRU/0q8/FVzjCjQpOBbCc1DqZrFki+ew9RFZOidfw3WCErsFAwN5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyC1VDFKR4qUiWGvH5MWjaPd4aXsYihuuy/K0qVlVnU=;
 b=R30Wotmy0e2rFXTuN5CLLsC+c4nrpF2UFdkEvTjNM+FBHMk3qJ4YL+zK4bMAR9pqQAkIsBvNObQR1b3uGsfEVWqRShdKZODM9SInlwbSsbP+m36nUUEUVEsH6pozsyMZVwp1ZcaaXSQwSRjgma8DDPSaWzqlVH00a0o3a7rIqsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 07:57:23 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:57:23 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v11 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Wed, 29 May 2024 00:05:16 +0800
Message-Id: <20240528160523.1695953-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VE1PR04MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: ab356b0c-c2cc-4c51-7bb2-08dc7eebced1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|52116005|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YsFIEDHV/icbxLjSJmAxVI2DBl5FaHmjgvgmgT+8OHREMnGJDevpAdD9E3IH?=
 =?us-ascii?Q?ApSmGiNQR1oC7fala6lBQn4ZUk0gDVkpRKqk5bhzjZh5bhOhtCswKBZvgBMN?=
 =?us-ascii?Q?z4T9hdSI2N+1VAb1zOsaw/z8GTPvc329DdLsBdSDeNZ6qPDgqWpyTgQy9ahF?=
 =?us-ascii?Q?NFmVco2241zhjfM/UNXf5WWgvjMso/nMgK+K3Lg19A8jV2jTqkMJdm/wCg10?=
 =?us-ascii?Q?OkQF0q7GhL3Xle6i4+nzf/kjzuQoDdJtXuOQIAUnMUoG2Vd+7q97twFD8+MD?=
 =?us-ascii?Q?Y7tTUnivDTp8bpvNIBM8fb0by5sU/KgAyzRSXkDK5wAiS+yaDZTzaX0b1PnT?=
 =?us-ascii?Q?ThPyaYwI+UkQHHG8VXwKWUSxGgoabzY3UsTiT4zwnxPexfA5oi6jz3cKrEez?=
 =?us-ascii?Q?rE1+iPf0n4Jz0F6nYn7yrop7bvpg4OFWY8KnmmRir+dTeq7cQkk5BIp0UUFC?=
 =?us-ascii?Q?6fuuZM4/e2IfDRp0uadjg+wqrwTjUvwA1OJt3sADBGv2SpDPTLAuvp4KvO6I?=
 =?us-ascii?Q?SLfrUld0pKUjeOZHROcIH1i2r8R2sOvJEePE981YH23XGdu14VjplQZ89Nke?=
 =?us-ascii?Q?amCP7xvaDpvsbTOv3Jow20Yimn1kEbNdwongDC6sD0vh870KLfrwLbQkqE7C?=
 =?us-ascii?Q?nngaJENJqYZPTg3uc4A5K9PyLLNKRsnjuZiHTuA2tjvf9zWpFm3U3GBdblvG?=
 =?us-ascii?Q?Diy2M27ODo0ok6cKiK+bv0iftNype57upae9u48B/UIytipuDlfRGPvN/Cbg?=
 =?us-ascii?Q?BTW+0tMDriVu7ORf2H7Ot9yIYjbVxS7f8b5fbz+CFZZp7X3zVHOEl2biKWJd?=
 =?us-ascii?Q?Y4kybVdvBpy/av0nuYp6A76f0vIhsNuln0F0WxJBoWmryGM6bcY/iSrgqLrI?=
 =?us-ascii?Q?+wt//ip0G3bjMu4Sg4iFXxTid9v61uqMsgVK9sRlq4IjviNPjZ8algRtjGs5?=
 =?us-ascii?Q?XcaDq/vpO9KNqYUrdRP4ew4CKk8lmQwGtlM+U0dnXuCYEm2kiXJP4hcQ7wVM?=
 =?us-ascii?Q?YcSyguf4LrqdVzcdZjj/ZDlkw4aJ8RXjEUCZrI+li0RTfURCgF97YSs6kj1T?=
 =?us-ascii?Q?nI7Yu8uzYjGrpUtssU5ihgDAcnU7Hsjy3nCanlmqLwdeBDnJSjEmwJI8fwJ2?=
 =?us-ascii?Q?g0yE47rIGE6X4ZzNkN6h0gVTcxAJDZBsbZPLwWzOH1mUuaUNZ3Y26ynRNb1T?=
 =?us-ascii?Q?+2oDC6KBeck8CvLTR0Hac7EEe6QtPqNbdeB8KC21FzUABOPIGhYmDVIqMfYK?=
 =?us-ascii?Q?MC5U8UJ0y+0V3sdloUhVjcZT61CIPaSf7vniUj24Z9IrPcPN4bVpwtDVxcm/?=
 =?us-ascii?Q?4PDsbQihgUM7+JYS9xpsBcY/Rum8iOHX3d/xFBpUZye/yWt+TmsGLPWH2IZ2?=
 =?us-ascii?Q?67rcVMg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDXZzlzEK+D4/93HFKdR4x9DaX8wBNraaiO6g0a2bmb28G65bdL8Y1iqMVvS?=
 =?us-ascii?Q?2KiqTyJxvSmmbgJg/W78M1EohH3d+Dhq/rSSZ5hToXUnYa8bg0+zVrEozEc5?=
 =?us-ascii?Q?zhI0OXdpVpKETa58SRUAHsan2mpgSLg+SyMTJaZfYZvXrA7SO9LQRVFOvLVd?=
 =?us-ascii?Q?X/5c7vZZH3nx6uDZEPs4poXR8Rqz6s4GffRPz2kxfnTvjx4sDSPSx1Jp4EHT?=
 =?us-ascii?Q?0D3tth6Lo0nx0OIos1SDzvAg5qoeP8hvBztTpD+DqEbM9AZFBGe5/AHTc1US?=
 =?us-ascii?Q?cBNPEUAOB/tAvZQygjrn+qfJBl2dzjCvVRwJqW4q4Jp1C0Wxw3pRkqfJNYEa?=
 =?us-ascii?Q?dp+em6f7x0O6O9wcsAHDjUUp691WBGzvEj+WSJB1+kepGYxuvNcOaj1G9/eF?=
 =?us-ascii?Q?RKh0ftzJ5LjeDbRwSGdvCY9oHhT4UCkP/leXyg7WPx3PyUJSWeskWOoJzkIv?=
 =?us-ascii?Q?MvoNl4/63BTOfEQ8RIcvZQxH/gQtl9zxRvE6OB2T/ssT0DZcnKMB2Rruqg7k?=
 =?us-ascii?Q?T1Depqbu5DCdJPak+ElTQ3QWqnvI7abv/99Idrz2VynEyFM1JmNcuknrURR0?=
 =?us-ascii?Q?2LSrJ882LPHwoKN4/7AL8y1/v4kslllpSbg+PssjWzruKjnMu53Y/FeIAQV6?=
 =?us-ascii?Q?0SQ81nSn/ux7kvrdXu5hXMlPGW6CF4mLpVtwa5FkuHO0dp2oaD2HXxdwgR+R?=
 =?us-ascii?Q?8M2HG16Rr12t2mRMWDm0Vy5SI6hu+AadwdmfzB1TbLbW7j/IE3dv9fhsqAMP?=
 =?us-ascii?Q?l4aMg3EJUalCnrnIjfyaBkWQGsDpWxgXnKD8ahRMgo67/TeEXoHQSUq/eLTG?=
 =?us-ascii?Q?j19OIqcLjgUuZxkZhcA+zVvpc6HCaKXjKqFTLiOcShmci99YSGotIlEkrOgZ?=
 =?us-ascii?Q?OgV30kqMdz042DGgahLguNqev3q8GtkmSHAstTQTW8JmwLxIo01D60E6iHof?=
 =?us-ascii?Q?HWW1pt6GqJOdELTfiRKrU0iibqaU68bHb2VofW6MXaIcVLA9EIBZu+ivjaYz?=
 =?us-ascii?Q?Q1YERYsPq439Edy3GDxVZls40i3awahhc6cuAEGk3dXHp4IBdJY8rapBIgF1?=
 =?us-ascii?Q?oxBQYnor5qrzJGGwEGou1Dyk8uhy5McSb6YTMXJqVE+12CijAUVisWcUUzU9?=
 =?us-ascii?Q?+uPcNE6aDximcb3DnVuxgSOAhgzCF5gUBfV70Kk970WP8nLm4yikArZZVQzr?=
 =?us-ascii?Q?9pJMu8yhqxsH+utT7iqbvrjM//S2Q6jBAeYlZAge98dEQxTMKm/GdTz47ENg?=
 =?us-ascii?Q?TV/xNKCSg4hycV/J8THQBWrdy9nxXhiwS1McIhzOCfoRYCZNLmEE75sPX7ro?=
 =?us-ascii?Q?aNlCBiBocffIcIK1XEbH/BSfSB05RtWOQ6hpWUoFslS6y8uyXzToRPprcwea?=
 =?us-ascii?Q?2cvGTk4M3/4LMNeujjohpfQE3nLB8dDxbwhQglcflKnScXL+QiXa0/fjVI7W?=
 =?us-ascii?Q?HPnPD1C0jR6iTPaZdmhH2UrlONlF0JQRzah1l/8s2aAhuLYZ6ln72RWvB6M2?=
 =?us-ascii?Q?k7M/KyuVE1ZRDEqk8iK1MNAKqVbc9hrh/DXg/l80A+hk3/uWgOQ84dTf61Z2?=
 =?us-ascii?Q?7PbCMrZ68TRasUwh5KjEvBfYkEHVBcgHRy5IcGYX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab356b0c-c2cc-4c51-7bb2-08dc7eebced1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:57:23.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/ewKQ0/7WsfVQtlwwLiYTmfLj5i9IN9EFb7K2oFVof7PDWHdRBBzCBtCw4EoXMsOQgpvcQNvKnx6oLkdGXAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229

i.MX95 has a DDR pmu. This will add a compatible for it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - let imx95 compatilbe with imx93
Changes in v4:
 - add Acked-by tag
Changes in v5:
 - no changes
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
Changes in v11:
 - no changes
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index 6c96a4204e5d..37e8b98f2cdc 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -30,6 +30,9 @@ properties:
       - items:
           - const: fsl,imx8dxl-ddr-pmu
           - const: fsl,imx8-ddr-pmu
+      - items:
+          - const: fsl,imx95-ddr-pmu
+          - const: fsl,imx93-ddr-pmu
 
   reg:
     maxItems: 1
-- 
2.34.1

