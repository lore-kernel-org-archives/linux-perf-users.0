Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C26F16D338;
	Wed, 29 May 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969874; cv=fail; b=I4XvIZcUzw/lLxhT/EjlJCMlFUDRK/8ZLi8qIcXw2BIeniLijqnyKNlsQiFvkAHRK9RXujj+wf1rMbbrw8BnMjtEKik/xzd/mANsycdqreVnCHbl9/CXqZyaU8G0n19jbYN8u6KhU7Wq+Dp4Cw31rEi1ljyFSxkgepuHwoCOXQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969874; c=relaxed/simple;
	bh=Ym9CMxxDEkd2eO213x9Ep+O36SPBU+umctj0AUHJWXw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eSwEvitCy75lDlF8SnOmhSV5Rw1MUUPgJ6wE7M2iZ/KiJvYIVXsJEkHc08La7d0KE5Ui3MrLmL+tOdFhYBRTNqCPc0K1rT/tYnjb01Nz/0dsPeSSN6Tj2tM5PIVX7bFmUyPmvWnLdgsNBr0mUyayM5cS2r9uWNSFmseBgZNHP6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=brpmVPro; arc=fail smtp.client-ip=40.107.7.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="brpmVPro"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCPSQ77OEqd8GqtcdTn6jM/mgjBv7rrZhTj5H5v6MHD9Xy6wrsbQ8x4dOwnvzEI6j60zMGHNwu/f+IdLd6iO6JNsr5xrqge97Drydwe4cQ7q+v83rU0xrJRy+EA8Z5wAz0vzQoP+zSgZKJDp4mL+XHxqN0QmOHyAkJpqdFBSPSLPKIN+50hQD8EH+UVp2z8WOAgIRDQN0zVPJW4g8pp/wqvP2k9fXJl7HCr8etG+e4zyLAk71xfI573LcuzUO9zwok2Duz35JHGOVhFWbreL0zZQomqPamZSg8pugoLdJUBL85iVXhPop51jmqEY1Dby4kbzcxe1LNnZjZoCwcUy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v7tmwSDBOSA1rl4087dqZxA7CFqSfCP4wY5xNi5cfg=;
 b=lxbbGLE/jxWiPXR01Gy21t9/hVKlw10NyAUrCD8/lsqIUt7xLUZuU4SMqvy8Ie4Z+Nt98lCjvMj0ZK2S5ogSA38yD/CdQy68VRZ4EwRDFyaMAZpU4ifBJIt8mPHIORb7oe9ouKqxjtWwxwKiNYU0Vj/v6nomaOS5jZYxNig29tiKLwvx3iYd8YWUoiPLILpKB3hu2ZuzlY7yzG7saMgPd3yiuQYQwNQdLH5fmg0uWC4vABbnuiATfpVnyMl9KqmpHhPy3nJEjoM7U0y5COci3wO+46gUDwxMGZjbA1tHLdjDsBeDWtLFr+quVvVrLWVhBvcf337ee4cWDZx5MppFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v7tmwSDBOSA1rl4087dqZxA7CFqSfCP4wY5xNi5cfg=;
 b=brpmVProhcC9EdzsUjnF3WlRAxI3Fi9RVtqygd7QIbbkZPq8+/z8749HdR4JN9jCIKO3H7YR5IYSURXJmxqKolAgaEh8UPCGeEYvUhPEiTWvJgBIj5EjKL5tyN8STJR/y12YQvrldXowZ9uIMXCHmh8Qlqs4xh3QZrrQwRbYPaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 08:04:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 08:04:28 +0000
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
Subject: [PATCH v12 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Wed, 29 May 2024 16:03:51 +0800
Message-Id: <20240529080358.703784-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f90810-551b-47d4-7d88-08dc7fb5f674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vwv+fXuv5G/HuG27LfqzOcRA+Izr9QwDtbOTbnQ9rTYfn/Ztaa8JTIGOhdLO?=
 =?us-ascii?Q?lBc5h9Mh1YkFgt5kfOm2GFGxHUllE7symtYtc3JqcrzsjmwKxMjSRYyD1TVh?=
 =?us-ascii?Q?ti1tePCePHXVdVyqkvP7Pq7MldSgJTrE7snLPYWytn5HyCQ0hn2MWyeGluIk?=
 =?us-ascii?Q?wovyE/12ZQ0U1Mbrnsj4+t2vUsM13zxWude8u7cQ70B/I326awF7swP7+Wqb?=
 =?us-ascii?Q?xNhmb9w+J59CPCFxw+2reiFxhd0nw3CLz0lwJkJEg5PA5g7W3LJ3ZwwKbilo?=
 =?us-ascii?Q?lCfyeIKmnYA3Ksb6pAr2Gw/PAxx9LR3Hw3p92hTkKYlFJRa7viqveoTNX0qp?=
 =?us-ascii?Q?eUjrg/elM1LDBRxoQvc4dM0FGyETR3kmVHQkBd5kDguPh7tMgt12j7C+tILt?=
 =?us-ascii?Q?45LxEj2UqbkpizT7z9qKCHhOjRxWidlkhVb2767sDYFke44McC5gf8haiZvG?=
 =?us-ascii?Q?lY25KL6FPTyQuwlS3WVyRLK1fVwOzJYo/EcoXDEcOX1kh/Np74uFxnRqAPOp?=
 =?us-ascii?Q?ktGRcDekVsDa8iKlvA49cbCkqpdLrPC9C/iS1ACrbmaiTOEruqAkWj+3Fd6U?=
 =?us-ascii?Q?FnSU1BCO/YOfM3762TNOjFzRYhrdwhzmxvj+ED/bpT/+iQll2YgyMZ61FbVM?=
 =?us-ascii?Q?0Tg3weX9WJnNow8oLtE9HRdIscAjMZiTxT0iu3tfERFsO/CiLCw/NerOs9Gy?=
 =?us-ascii?Q?LM+jYE62o2/ocoilgUnMauv+uoX1bWmOaSo9JQSdno10XTx9ogMJpquNTp/R?=
 =?us-ascii?Q?A6KJzM6iIJbkUlZXkLnilmG3zkqF0IMIu5ouheoQYIUrLwKbWyg9JkQ/WsO1?=
 =?us-ascii?Q?tLrT7miWEhCN7wbldeI9BNuT2/ujFR2du+baz/9XojcAGyFRPfEbj2+wnpHc?=
 =?us-ascii?Q?q/Bg8IqvHBZ6WOrQ0xbQHd3Z/Q7XvqatQkTboKaiGo8IdN4jos0L2D1vFLG/?=
 =?us-ascii?Q?7c2CdXQ/4YPguf1OVIeOdiJPFATT4rZ2gXD9astWpX9fUG+XMdAnIjl97r0e?=
 =?us-ascii?Q?yO492+JULPGVLLwJuFLpxauPpo484UZ7Q+9qdDZjtFqKu7N/OqwgwAoj/9dL?=
 =?us-ascii?Q?XEvlqVk3fo/gkOmMIIoZSCiG/yEPBpthRHuqKpD7wduvsE2m9t1D2hxoN5Sf?=
 =?us-ascii?Q?HHSQrzM59a5fAa3BWAv2c914RL4dyz3S4n3VVWTNE714ncVPXrIr3OylkyUk?=
 =?us-ascii?Q?BkbLguBaU79E6JjS1qEYrDO+Z4T6R689vFi6VLeqQ1A2HMiKTKre40CmDhOl?=
 =?us-ascii?Q?xWnGTB2U3yF+93VtZLe1GA/K9XQDKA0LkXQSl8nsHTA53O1BtNOcO2imtB0k?=
 =?us-ascii?Q?9b7rTee54gT1p0fJhW3sodmn4HLz4jIM5fBBWhZUpbRL0FXCQnIiEvkl2kXv?=
 =?us-ascii?Q?jG4jbqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XwBWoIC6ggicdw2WTXiDoOqs33h22BDh76XF5K8wWKsCtvUwP3Qc2jte07A5?=
 =?us-ascii?Q?aEv5g7+qPuhYyFcOt83G2n/TCB1xsNT4isUbwilkPUCIXFAzn32BwRfBJOeT?=
 =?us-ascii?Q?H52Zqnfw3PTwhGa7pkdQmLSXwkczkTPItoL5hKQWDgRJBEr/62gtAGMGigIe?=
 =?us-ascii?Q?w7YYbdvG81JPVdZjBrKVyrCJJWyK0+hDe+uCV8ae4NO0/AqiQIx06ed6Mx1J?=
 =?us-ascii?Q?wCiZHLrNDU7OZgtgsX3bc2Z9AsZ8U4WjCKpIZZxz+zB9l2SYDyqVPDeZinuP?=
 =?us-ascii?Q?bxONs2Zq9JQ6QSpYOOe12jPUx84ViL3NDF2VpvzdjacJmzEFzK9iNPqCEgxx?=
 =?us-ascii?Q?q52kJZR/VI+ymeIH9PEiuObsuup1uhwBIwzyrbYyhUJn1AzgDvX6jATZDvEV?=
 =?us-ascii?Q?g3j/adi1hv+uWp23w/xWgjKwfTjtpuyCUyPXD2fknWP2e7sxcNkshvk6qMoM?=
 =?us-ascii?Q?MeQtk8RDYr48cBN/qMhK5vvyuwuikNc0F84Zknqs08OPgl0vUaClZa4SvJIu?=
 =?us-ascii?Q?pYQPHybYuJzeRlPX9ddAPTA8EN38ywga0x7Z6zFyLTqoxunBINm9B3MD+W9O?=
 =?us-ascii?Q?W69+U4fDKOtdnmndbltNrsF7SsDwzwxVba/K+0DzigSVfBlvwniiX9BApZ+o?=
 =?us-ascii?Q?v8deVAAgrxi6SVMll4KAvYSn1roFURg3719AevUtt5JuhvrNJ7qpdGoBHEPa?=
 =?us-ascii?Q?uXuKoInxAnLL2eDCeE1THC7LLykV4VJdrwzOVWz+cag4FAx+wYCmHNQ6PPeG?=
 =?us-ascii?Q?oIJskXAwmbExK+Kq9PXsobM3q5AAE31IaZZ+El9+wMGlCoxitvcLYmZOEmH5?=
 =?us-ascii?Q?LhBnZkF81sr5U3oZe86Hsnivh5TNazI9bRw9pmxdbXcEIM56loBXqFRzWD8K?=
 =?us-ascii?Q?4Db/n8pgu/noMlN1tgzjnCivc4tVx5xcblphr0w+jnYRpQpniXBwdRPqTMnl?=
 =?us-ascii?Q?yDW3hY7zRwSsa70AA06bOaW+36SXtHRFMMcMWj6YMC0vwYJs3XNUZfS5ckOG?=
 =?us-ascii?Q?vfU5XrXwYU5BeZeL7BDrXZnl/gG++II6jkB7za26/lLUkGKGtZ5hHOP5+wH9?=
 =?us-ascii?Q?lUojMmWpqX6jX0ngHfAQFpUpP3PY8amKZqbnXmjN+ip78AAXKA5CRuvBotAG?=
 =?us-ascii?Q?B8V5Jj0ll+s1V3xf40va89kRgRvhnTIArZ1WlkPUJ4x6jy9Wyt3+BDB8ztIV?=
 =?us-ascii?Q?EiccD4c81aKqyLDusn/xKdbPjka8FkXFqPW82FjizkH+203KuH0wR9BJ2XuW?=
 =?us-ascii?Q?rI9bAHyEMuRvXwhpn5CaSKa7GEkDoA6ZOogrkFdiVK7/HjZBqWlM2TLFmNlQ?=
 =?us-ascii?Q?0EiFZDvKc10vUBCdS4JZXxhS7DDyqgmnt6spouOlaT5EdA3KxNFBy3boRUix?=
 =?us-ascii?Q?61a3Q+UgSfLOQqjzwjUJEXXm/TK59xI1RKVZHhGyYG1IDC7fpJak14LbldMd?=
 =?us-ascii?Q?2usUdUlnWcvuXRDsue7l/hrEMv9FPo9PAy/BnBHQjUgs422Y04otlmOmCY0X?=
 =?us-ascii?Q?MRrOL02c/tVjwOIMSbf3A4wJM35ZnUPPIMh/CRPWqVonxX6cxTwSBEPqLymb?=
 =?us-ascii?Q?8WzbJyVbsNRgDXQT+YGJOgNXoQsTgAd0ioX+bmTj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f90810-551b-47d4-7d88-08dc7fb5f674
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:04:28.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6I057QLTMDru+ATnNCmK6zKwE6An5mQ6xe4BR5xmNL2tWhPz87Hcvf4PC1vhFtrzqjbRjrAOw7nqffQrJNtuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

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
Changes in v12:
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

