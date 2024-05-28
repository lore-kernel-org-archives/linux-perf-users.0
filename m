Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8813B293;
	Tue, 28 May 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883072; cv=fail; b=fQNmQ2douwnHVXDhQ+uFnLSomBlcb3jOnOg4U7gmWsChY6HBH01wxAdYmPfE0q4belZAEPHoRVh7s/xZcyJpsaqapyOXCzh1FFUl9WNgbe6AJo72YNcpsQnrswkAQRqt3Rn6VRm43Z/3f+gZg2veFD7zGTmDHeNKAH7C7W6tfDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883072; c=relaxed/simple;
	bh=DBMa/tL2seYU3OKpRosgfnF9Nwd6mxxhz46SUB4ppZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOC6zCDbDQiwOmdBJQjwYN6lO+B/xiVcn24ngfavzUHKnD3R9Y8s6p8qBUOlnKpl+OIS25TO2X315KJwkFV6zOcbylNzdRJe7HHxAB2ZETgB6kaYsNfZghsS2Du1PdMQgZKm0FBmpESSbsd54h5biI53R0JzQX0x7vSsazNgRV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rZHsGRlb; arc=fail smtp.client-ip=40.107.15.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rZHsGRlb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzSZkh7FodazzERKfd+nftal1GciW5gK+9i+Oqk0j6L5nTAsLCe9174IT17xTNNEwsNHp4pMFqjzz6oXKYwLdpUjXjDjyfL2bGnqHFiO6mnVywir1eZ9yhP4zsliomJVWR//hdOEvgc0Gkk9LwF56A8Z44Y6TV3hqxAtJspMwr6kdg7mLs+L4VOndP8m4Rqw9vNWXQosqedslr6a5992vRpb0K652ScL39OS7zLdICXARMo4t4C+4bpe+qcrQNP7ZH1KlDy0HbFSr11p9OASyaCUd8qJUyg0alGxSOUhVv+vsTcfnwJLqV0kS4VyPlO66NmWaMTYgGnD50tKQeykDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyRXU8yjj6dhDwUSGP7NGal/wOm58jm/aNsqtOIsUsQ=;
 b=ThEictOH0dIWI8wmNbhJKo07y0heBqOAmW8L7zeJ5KXcCjJMWdgEf302RfwBIwT6riO6rvz/V54RXO8SjDJVtKXM8FTjowa/oKvucjvvJUeQKYgr6cKQeZ8hf2qPTZfLYHQ3EQETDodk3pc6gbaMiP3O9rLUne8tGCaw+pcqv4yUAeQ5ICn4Dfi2qyVIY9ANGxx0lJzBYjF6V5Lb/zGTdFgQdjk+Z26ig+QNdnW169reFYZ2j8p0OKQrwFsAIPhQ1hNcyp1GELYs8sCXQHNc8mBJUKKckh5lOB4+i42awfga3QmAxeeFLFHpajqAJ7hBsGL3eLvzcTN57yklptL5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyRXU8yjj6dhDwUSGP7NGal/wOm58jm/aNsqtOIsUsQ=;
 b=rZHsGRlbb4l90KdvpuneUtrj3RhJqk0LikpB7LGtyzzflOpVjN8geCC93KQp3bJbgtkai6gdPN2MqlK0rvJPgrrpAEczr4viaN1/sVg2wCN/yK2mUqjPnOodCF+6wPYGR1a/Oo7//+5/++5shrgMukza8EjzF/ClHDif9rwc5p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 07:57:47 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:57:47 +0000
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
Subject: [PATCH v11 4/8] perf: imx_perf: refactor driver for imx93
Date: Wed, 29 May 2024 00:05:19 +0800
Message-Id: <20240528160523.1695953-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528160523.1695953-1-xu.yang_2@nxp.com>
References: <20240528160523.1695953-1-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a7f80a5-90c1-4516-6575-08dc7eebdd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|52116005|376005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JG5xJbIOX+OJWkknrMyQh98p8Sr4KvIeThmU1VYpmC9T0OTik3R7z4kvOv0?=
 =?us-ascii?Q?hWEiLsIlE0ZZ8a9/0BGr4dchj6UngBkTSRlwYa+ZtpeP/SSzg+uwZpcaYVCG?=
 =?us-ascii?Q?sFqZOcvnzbHovjKI44YqYJ5rrljosvlwxgV1+lWlp/3YHk46ODmj15qS6Y/X?=
 =?us-ascii?Q?PdQ+pA5/XPDGglalrH7iojI1aZ98TAdUJny5smQRnRl5cGOXyXLeDM2riPgF?=
 =?us-ascii?Q?/mp3nRUEQREV6/HZwN4rvzWckKPvFUCPORu9z24HFN7IYRP3K/G9Ped5gyeV?=
 =?us-ascii?Q?OvhYe7xGkuK97blLf3z+6TmKIz7kJrTJGii7jFSGhWZbZjs3Ij2SqS3lCglR?=
 =?us-ascii?Q?4jCSAxfkyAlVHWE0gz6JpUEDZOAzfMcTolccalqBEPM5HB+px7U7C2fMX5ks?=
 =?us-ascii?Q?NBtaZ3gzVgmwYMVRUCNe4EfuueL/Qd23tbSouHXRiSuDCmXNtBc0z93PJ5wD?=
 =?us-ascii?Q?IDrjxjDymI7pfUIrNnyuuiu2iiTkAYk+2mUGqANeFz8YqcO9hxmc6zP9yiMV?=
 =?us-ascii?Q?ww29+GzXQ53OEA25k6L1I5vrkTNGHBCYH2QEtz5aTtXmmXcwjd2ItEFKoBCD?=
 =?us-ascii?Q?f5F5MDD2QR+0toZThWRWg2K3E5hS/hsOmqsS5lK4yb7mdjCvPgEOVPD9uHSR?=
 =?us-ascii?Q?jVvHC3RXRgXOgu5pXuDzFDbxcz9aHBsqIyKoX7InLSK4to6BUeSlFEU5RGjI?=
 =?us-ascii?Q?LauRfdN1LnnL45N39jy1bFFODzriVI5xAnyxBgI/L7CwGk2GdO53QS4KyzIV?=
 =?us-ascii?Q?5Cl3GHWWV5x39iIwuKRwgWtAH7/9l/o8kdj3thC620gVp2PohjuHilzqTLFf?=
 =?us-ascii?Q?sOKPfWEIz0TcmXMEauYWNhH8rh9XlbqRI0cPyin7l2etuzOKKwiadX5AziOQ?=
 =?us-ascii?Q?EvPJXLVSYvYzEkUvNU/FjExxirCP+Bgn3Wc1e1ClPBYyBUO7GOp9qXOqz2zu?=
 =?us-ascii?Q?GBNEgiiZD/nlOy0XVUdbQJYAoC/xRZekZ8Eyb7TJsceP7/1c+XehSBnZLJxO?=
 =?us-ascii?Q?qsVrGRq620dMi4BlyTQhVX4CTXtPeHx+bxQIKz+QxvgZaoLZuR8eCrECPNdi?=
 =?us-ascii?Q?xodZnsafpTQmTX7dS9jfxXWMus6/3+ATz2nQblugl+vLLKjIY53oNcFw/zD5?=
 =?us-ascii?Q?wLmdbgJLSb26S/v1C7Lu6sXpD9bOFlJlxjq19qvz3T8z3YTn3OHYYYyNawbw?=
 =?us-ascii?Q?820dm3se6J5deZIhEaeBIYO/sSFeBd6rWRaV5V2ChJbBDBngQkdBwwiBpEZn?=
 =?us-ascii?Q?yXQDCVFviY7Go/I7arCMRMJVJULggwWRAU28Q2E57x5zwFHoRfgI4djM0T2X?=
 =?us-ascii?Q?VR55rgKmYS0C9kydyqOZzItj9XDFtA6hM4B94FdMAS3S87JmS+rZSMLUUHnc?=
 =?us-ascii?Q?xCYl6tQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2G2inMiGiVRWbhgIvIKRqOiFuVvMIp8vlExiL05kp0ehHVktyuUyVHkUUxi0?=
 =?us-ascii?Q?lGCDZVYebPXkYfiqcN6fr61L2WnIF3SfdE1U9bfxMQqweJPsMdvuhyO1CgH3?=
 =?us-ascii?Q?pYPIAFGAvIzP0lBDHTEoo9MzQ6ej5d9XJsJp/lHWQc6BR7KVky5v9tieZ3zx?=
 =?us-ascii?Q?FRla0i5Kttqy3pj19wvvXM65NTqLCds0TVIvqw1W9Gp8otugT3Kznsax4mpX?=
 =?us-ascii?Q?8vpae5ruo5jL9Gx1DPza7Mxe6Gm5dPlA03O9sqljgpQ9p0OhhayZFQkw68fD?=
 =?us-ascii?Q?FFCWK37L3JBcZnUgae62UrSETaNnyccfGxFYhUgJ9EocX+UlTLCYK3ME8Uz5?=
 =?us-ascii?Q?1wxNsKlpBjkmoXsT9tvLJj9RjzlI41idVaVhqP1b9ihB1pakzhy6ziY2TevJ?=
 =?us-ascii?Q?XRpLyEfdxnhZoE+6kbkpSyVyR+jH0WW4bUUUjCAzVn6hBjSkOq6GUOuVqVt5?=
 =?us-ascii?Q?uVzbluXdpGF0HvF7PQoLD77CPqSns8ciGBAom57B4bJ51iNRif0ZNKPiN4YC?=
 =?us-ascii?Q?hMu48p0UmBb3EfyCW6EwwZPfWAIEFveGPjlBTkRkKFeFhX7IeiAYdfIweYF8?=
 =?us-ascii?Q?NwJdft2XzPZ+GtTsc9Lr824WzaSj/z+Vl28fHHY0D93u8RpNKfiBaG2hIkyk?=
 =?us-ascii?Q?vuC76UNlFj2cZblH7Lxk2/M4FmcWT+Fw+jznkTu3wg0yFcUSwltxh+z98w/X?=
 =?us-ascii?Q?TScNor/7Rm5PP0RWZHu9rmejmhXiJbKVuDz5QuFh6pk3lqe+iPsuHquUq5L0?=
 =?us-ascii?Q?+rtA51tD5woVQ+JoyErEuKYxuCGe/QoR+wKuLiU+Fy6pi1eW/arRb02SPEEj?=
 =?us-ascii?Q?kJPgAn1ykda7qLz6Y+WPdCXdOnyfTPlvE8E/Sy+hGzVkE3lNYim0DJYZf/me?=
 =?us-ascii?Q?/WEGSg/KVxuOdBJwWFxSE7dFLWDDnkkeNQBcjo538gvWWvqAqbVuMpPdpPL9?=
 =?us-ascii?Q?yY9vK27ZPVWVUqfkCbtbPMV683NaLu9KQWv3e0SQUKgntI2sMgmuFncmNQgv?=
 =?us-ascii?Q?lVkNi5g+K4LiZQGAf/8PZOH/CBV0/dVImluqHrjdl+LEN5Ad4JW0cMHvoEn3?=
 =?us-ascii?Q?K7XCpHxF/+PDBPrx/EFWKCnIK984sw4WqrYZPvWN6hEch2sZhZ7F+OmJZ0y0?=
 =?us-ascii?Q?O/lZvpgbyswVTt2Rae2hqH7F1TRgFZsXagWAlfV/OpXORGiKIc5EbHFwrZFV?=
 =?us-ascii?Q?xGVaBinSlIn8/xRJ01jiqUU1UWj9lx4gzNv//srgW6T5qCCGOCsiRYOHRm2f?=
 =?us-ascii?Q?+/zfOsf1MHcTlRT3kGC3N8gOOkypADrY2G6SfgJvrEGtGHWZ/2+lVxwwSGxn?=
 =?us-ascii?Q?p1sGGK6Jb5VNpiEI3VLtGzV1QUUl6u8S8+RDimagTrpMlf6RCf5epJ/dkKjM?=
 =?us-ascii?Q?bWFTlXA019uaBMJv8/0jkfQtlSUzswZE55oAjVl4/seGJf6wlaAY2s6+BsKZ?=
 =?us-ascii?Q?HjNeF2dW+btqnA+hy8sirqH7rsoYrZPD088t1UefWeFuGi9hByn4cM4wpaII?=
 =?us-ascii?Q?NuXxkXa7Q+F4Itf+afvQ9GdiInfrLOc7bB91KugXWrizfz0Rh0juAqVLgM64?=
 =?us-ascii?Q?QwRcbwnJgfzJ2/msvPZb/yMzNv3ImB3oJR8WuuF/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7f80a5-90c1-4516-6575-08dc7eebdd37
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:57:47.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuiV2UrRQU+F3pU16HMjgmLkT5lau9MdqNawgWshoLM9YzuZ+ka5AcssB8RrkUTCGBCD+FLI8OJ+E0slst8xNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229

This driver is initinally used to support imx93 Soc and now it's time to
add support for imx95 Soc. However, some macro definitions and events are
different on these two Socs. For preparing imx95 supports, this will
refactor driver for imx93.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - use is_visible to hide unwanted attributes as suggested by Will
Changes in v6:
 - improve imx93_ddr_perf_monitor_config()
Changes in v7:
 - improve imx93_ddr_perf_monitor_config() as suggested by Frank
Changes in v8:
 - adjust is_visable() as suggested by Frank
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
Changes in v11:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 106 ++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 38 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 15045fbfc685..d1c5495d5e48 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -11,14 +11,14 @@
 #include <linux/perf_event.h>
 
 /* Performance monitor configuration */
-#define PMCFG1  			0x00
-#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
-#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
-#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
-#define PMCFG1_ID_MASK  		GENMASK(17, 0)
+#define PMCFG1				0x00
+#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
+#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
+#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
+#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
-#define PMCFG2  			0x04
-#define PMCFG2_ID			GENMASK(17, 0)
+#define PMCFG2				0x04
+#define MX93_PMCFG2_ID			GENMASK(17, 0)
 
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
@@ -75,6 +75,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static inline bool is_imx93(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx93_devtype_data;
+}
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
 	{ /* sentinel */ }
@@ -122,24 +127,37 @@ static const struct attribute_group ddr_perf_cpumask_attr_group = {
 	.attrs = ddr_perf_cpumask_attrs,
 };
 
+struct imx9_pmu_events_attr {
+	struct device_attribute attr;
+	u64 id;
+	const void *devtype_data;
+};
+
 static ssize_t ddr_pmu_event_show(struct device *dev,
 				  struct device_attribute *attr, char *page)
 {
-	struct perf_pmu_events_attr *pmu_attr;
+	struct imx9_pmu_events_attr *pmu_attr;
 
-	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	pmu_attr = container_of(attr, struct imx9_pmu_events_attr, attr);
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
 #define COUNTER_OFFSET_IN_EVENT	8
 #define ID(counter, id) ((counter << COUNTER_OFFSET_IN_EVENT) | id)
 
-#define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
-	(&((struct perf_pmu_events_attr[]) {				\
+#define DDR_PMU_EVENT_ATTR_COMM(_name, _id, _data)			\
+	(&((struct imx9_pmu_events_attr[]) {				\
 		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
-		  .id = _id, }						\
+		  .id = _id,						\
+		  .devtype_data = _data, }				\
 	})[0].attr.attr)
 
+#define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, NULL)
+
+#define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
+
 static struct attribute *ddr_perf_events_attrs[] = {
 	/* counter0 cycles event */
 	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
@@ -185,7 +203,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -197,7 +215,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -209,7 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -244,9 +262,29 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+static umode_t
+ddr_perf_events_attrs_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int unused)
+{
+	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
+	struct imx9_pmu_events_attr *eattr;
+
+	eattr = container_of(attr, typeof(*eattr), attr.attr);
+
+	if (!eattr->devtype_data)
+		return attr->mode;
+
+	if (eattr->devtype_data != ddr_pmu->devtype_data)
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = ddr_perf_events_attrs,
+	.is_visible = ddr_perf_events_attrs_is_visible,
 };
 
 PMU_FORMAT_ATTR(event, "config:0-7,16-23");
@@ -370,36 +408,28 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
-				    int counter, int axi_id, int axi_mask)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
+	u32 mask[] = {  MX93_PMCFG1_RD_TRANS_FILT_EN,
+			MX93_PMCFG1_WR_TRANS_FILT_EN,
+			MX93_PMCFG1_RD_BT_FILT_EN };
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
-	if (counter == 2 && event == 73)
-		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
-	else if (counter == 2 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
-
-	if (counter == 3 && event == 73)
-		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
-	else if (counter == 3 && event != 73)
-		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
-
-	if (counter == 4 && event == 73)
-		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
-	else if (counter == 4 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
+	if (counter >= 2 && counter <= 4)
+		pmcfg1 = event == 73 ? pmcfg1 | mask[counter - 2] :
+				pmcfg1 & ~mask[counter - 2];
 
-	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
-	writel(pmcfg1, pmu->base + PMCFG1);
+	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
+	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, axi_mask);
+	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
-	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
-	writel(pmcfg2, pmu->base + PMCFG2);
+	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
+	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, axi_id);
+	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
 }
 
 static void ddr_perf_event_update(struct perf_event *event)
@@ -515,7 +545,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
-- 
2.34.1

