Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022076.outbound.protection.outlook.com [52.101.43.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056C12E1D9
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821810; cv=fail; b=D4VZzpJBtTvd34SkrM4OalbfudTLz3asmIYp9/JPMy3evcsTxaYqjr+kRPi+59aYt1hI1ntpOgYIB750Xsw1Xcld5AseJlYdmNWmO2CafQgTnQ+vEiDRXDZkE88JMsFKqBa1OaB8AX6hrxTkg1oKlvm/x8uZnxoCgdVHUTWGpxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821810; c=relaxed/simple;
	bh=Xr1Qyjtp9iuQ7I2iF+10nCPhwecTo+cjjTWS9sAMV6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5nT7qBazRHMorUxSfTTW1gBkCiXjqzTjOAtVT4isdCGq0IaPHbThYUjdNngQ+lW4RafPanGn+sZQnLWrBdUaina/KYif/tRldjswnaL2nuf/pPRG7fUptQh2nVgS161OKCyEWik+a4PqSuyXj3CkLwpJLpSFnaBkWhtqD7F1hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RPqOSoI0; arc=fail smtp.client-ip=52.101.43.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RPqOSoI0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEtPPlO00jSrRRxM1OW3SCCqdIz8ucyQfrYq7Nz2pM6vehwYECGjz3wAEOY3KYg9zXyv0RQvHw58h52SRceaODq/oBKEVYrtG5UJuatRpkuKrV2N4dcUQ6V7VPi8BaJsmPfoDOhIsZvetD8DdqLe2mCI+FJjVYFWX6SUeWPdJYuSbn0GK7AZx7PAM4F649Twg6Sm+pQWn5Wf4Fl6YW2Fr/20A8vkxeUksKnQE5bLYS7bw+JBJ8qjr77C/GnyWDKA0un5TLQfhKTKCcWrjdubjydFrp2sqX3Ta8sq8JAwTHzKusRWCaUuquLj2zFc0VFGnIE4V+AVyLur0fjgMM7WmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inrivzrO2TQ3fiHjUu/vhMGnzDUZat+IEmtcKkCXFF0=;
 b=GC8myhrEKIfPOo8/wsxnRbWgDVO5rkBuh3z5nf2Hr0QE36f3+PFtwbwRwImo/BTmOE7ytFfDyLczvi1Hgr0viu+tAKwR74WzaNDfiXywouhA+IIlwcg4qdh3g26ieQGon8EVpQk4CyTUGqGTDLSgOrX0tDKX4ZH47am9hEEG55hSJCdaVRDCF/qr6FntXoSAPZZrXo5Gnn02TRR4wnbWE+RDSYfChGElEaOzZDCnhTGl1uKZ6/Q7G2+A/jP6CFbTsdm7JEAQw/uAgLR1+498kGniy1qhod+yNOFlIDLuVxwkOvmEZgxDBNRon888DsthCG5tzo2BaNrpEvLvxtVAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inrivzrO2TQ3fiHjUu/vhMGnzDUZat+IEmtcKkCXFF0=;
 b=RPqOSoI0auwMCnA3acgZmHi3JdKf3AlrgwFjLnSbL23qz2w67xDs2rVKQZk7wsej1kFPorQRzqIxcCO39qxbgqrc7IMeNzFB6OEzxA+tpsWHNHoX2lGMkqABmbQmjs0YmB/asHYsR0kAgr0oD9IKluEYgVik8bX5rxxrQAQGqEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA0PR01MB6506.prod.exchangelabs.com (2603:10b6:806:eb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 05:10:03 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 05:10:03 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V4 0/4] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Tue, 27 Aug 2024 23:09:40 -0600
Message-Id: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::27) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA0PR01MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 049300b9-dc90-4bfe-9290-08dcc71fac85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mDg+Je1Pt3EuZQ8kSMxlBShte8vu4QpBwIRXi36U+TgfLKDKf9ur1ZS/xQnl?=
 =?us-ascii?Q?6tW7n86/dXS9maF5Tap1BaCFCqdbJGmlhvAs3xqQBlX4OHgynkqmAJhmC61t?=
 =?us-ascii?Q?W+gKShvaQ2g0a2zj+IIs01BPP7uD+BjRCx67znJgIz3Tnt7wqQGSE9d9HhIO?=
 =?us-ascii?Q?PduLnK/SgzQ67I8oXNHNFFI2Acu3LX8Yd7MFlRv9z0Bq5OokQqODhrUA8c+j?=
 =?us-ascii?Q?q55RzrkuR7fVgzr0Sz0SFSM5OO+9NSrY4YdVID0Z+BldRdTvpjcWWuvCMG/1?=
 =?us-ascii?Q?rEdR5WiuYGpZinVGHgaxZp72ygq0VBuWq0HxOwcV/VFcf6YH0/XTmaGNMYNQ?=
 =?us-ascii?Q?ePyEYZ6kicCjlXuojNxRZrhupRYNmnukFTL2SCnjuS6uueFS6hnMMpsonEij?=
 =?us-ascii?Q?n5YK38219yWeh2KAYgE/wjjkneLLZ0i+/Bbk8H2d0eXrGRFyp374xEydBHM8?=
 =?us-ascii?Q?OovihKAL1B2YNL6skcFc8/JxwC9sNSkjy8SnKZB5j/FcYcqRUSs6jb85GEqM?=
 =?us-ascii?Q?4r4r9FltnLyQLM+NjRwen9BeEWYDacgi2G1jEyzt5QAKvobvnz+ErHx1Bu/r?=
 =?us-ascii?Q?GBVx4LTFEtd4/1ihsaawq6bAx6qClsjeJ21WKsowBp6owm+q3EJ8GN4ebfG0?=
 =?us-ascii?Q?zTZAq4MFtiaFySkc6w0ng6+F0WNm+TLr/ZrtTsO4mdzTQOVFft26NUKnCXe5?=
 =?us-ascii?Q?d81kMFaNSxN2pZ12lXj2VlIvBSxGoWrmRsdAOkJJSOdKOGC0td1I3/X32L2b?=
 =?us-ascii?Q?PuwGgVQSzj5qJCpe6pslJAUy1E4cOK5UvJ3XrYm22sVDUOktWGJ9z5as3Yxq?=
 =?us-ascii?Q?PrpZr0I7fXfxTxUw+iAP5ZtRnxOXAya7FqUyC+3rpcI7S6Bpp5qFa2IWtNNB?=
 =?us-ascii?Q?C7t1Jvj9rvjN8xq0NAg0sppmSqXczZjnusxIwSja4KGxm4jAAV1Rtdr1GtPR?=
 =?us-ascii?Q?V+kdRx7h2JhSgNYUPAyHMcMOhIAxDSE9b/aCv32lhftPF/4p+0uWCT9DDSG7?=
 =?us-ascii?Q?2uLCYRtjDGWicGvkYmhCNl4oNFQwH2/s9dePGDtqhqVfZT40XRejG8rnAjaY?=
 =?us-ascii?Q?lr2DMjDFDh3shn756uwAYac3K856N3WagfD+PhifNBY72/vl9lXqoQ0XYcxy?=
 =?us-ascii?Q?iSfV+xO9OenSecrqsy355OO8idC9JW/goF7Zh59nsfV6Or63AaCHKUqtVOhG?=
 =?us-ascii?Q?22TqxFfSDgsgQe/XwWdI5jdO2O5CD7cSI4t2PjEsRTC92fLEZfxRHjhknWcY?=
 =?us-ascii?Q?82AhXXy50+JPwhCJfLpyUPrCd5ZKh2kvKo0E2qk6FbejYl3I/jNXedDQKNXX?=
 =?us-ascii?Q?JST0fXLdI93staE1SRPwPRINosz4IsbnjBnKf0iw8nnAPrDbjZydJ7PEj6JM?=
 =?us-ascii?Q?GaD233o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqso3zikENlmTJannEn05XXyTXT/MBrYq4MmzhwmbJZ9ViRj2Y0vWmdql18n?=
 =?us-ascii?Q?eNR5DC78O0zZR9KrXZNCBay73YfbpmYlWAsxcUQ95ADCAgERwPFCaJdrXpqo?=
 =?us-ascii?Q?vz/zVrD91OoTIOeGV9V2ZZf+irB5NXtTptjlciifjj5Xn4EXhavsAFT1loPS?=
 =?us-ascii?Q?QptWfy9Zexl01loHnrOOcK7R6cqqx+NOKeyOrfnlVIAZzA2MJ9JM6ryAquHY?=
 =?us-ascii?Q?4UyT5nkT//Xd3trB0gMNvWCw8H0d0wm18M3gQGzcTjLUFL5CY9FyrYz7ThHh?=
 =?us-ascii?Q?j4z35kXpJYBoGDYzstILwjqtBvoLkt+SgYYcQyFb7tsCclobKu7AhzO639/p?=
 =?us-ascii?Q?djhj2tV+p+h5rauwkK0VvSW8f2JDE3pzEuSX34lKkAGXtDa9EsdSPLKg2fKQ?=
 =?us-ascii?Q?PERIrSQf2GRKR/GyuU19XkLpEOwuHmGt21ehyWtrkIUd/nvSNAfrn9S10wLK?=
 =?us-ascii?Q?NfE1cpLO13yJvCMg/PvmgU/FvGz86Rujf3GN8W7E2hBQCMqhfT2lzdMA4w7o?=
 =?us-ascii?Q?TwT3LCacJlvGGVLnKSmKgUZCz9WXixWvz8GJ/4PskQ9GjxDM9A6NMvGBa+th?=
 =?us-ascii?Q?/8Z9vePDt9mcdI1S3cCrhdjr3yzsIrWLOFpMLn8CHvgq2vOmNKcZYNTpEjfe?=
 =?us-ascii?Q?zbbRou2uURLIx/KocpkA85F0sWyPtMYRlOYO313G7LocUcINN1En/0Dn3oly?=
 =?us-ascii?Q?o08IappGIX64VJsnVfr81dNPKE/HWoVdDO0xqROoGGyRdozGn+0vz7oGZ2py?=
 =?us-ascii?Q?eT7cyDOZkynvHzNAuygKDvs9c5NtO3ekhBywkLHH1KDy8KbZnJWOgwH8rPRg?=
 =?us-ascii?Q?AtPtRQs2Yd7vbFMa3Ju3bFFS7g0oGIrRmiNGdqOJes+HM/r6xDBclUaK6GKe?=
 =?us-ascii?Q?V3AyetaFajpGVOcSZ3TrNbH+M+0TRZUewQfbef4TdjWIk72lyy8eaVwqxS7T?=
 =?us-ascii?Q?Pvl2r8dWx5RbrF7PkMztPhEGQ9YxRG+jnHCniW8erLTNg03iS6KB5UlxqSfL?=
 =?us-ascii?Q?N8df0Ur1wuvFAPOh55BpO40Yc6ZI54wm48KhU9x7Yte6yyjPZ7hREY0PL3sW?=
 =?us-ascii?Q?pCkGWd356U1Dmf1T2Vcx6CvQ92oP5IJUk9kbXBoP09mxhhi/Y35XXDod8jZZ?=
 =?us-ascii?Q?e4GHD63bKbSL0CYmvmrnLSTawGxQHpODwpQvz3y7S1RG1DxGaE9FqipZ01s9?=
 =?us-ascii?Q?H9D+6hixwmafW6+ncLfBmNCJRSygm2Y/AaJxmI72LzfuZsZUdD6ralR5XWsH?=
 =?us-ascii?Q?/tMfmNErjxjxhGsIX0/zrVi6PSF0nWLAkpcdU5stfvufyhtEYFmvKreSZIMO?=
 =?us-ascii?Q?e0Cce97yOzdaOYh4Vwn6RlXjJKO7C1de0EQHAqMJ6xcD1kIXpnvGHtEr8q3s?=
 =?us-ascii?Q?8GUxGV4MAdiB+JMT256+khdXPQhc/5DgGSNGx6OVXJnEUNBLUUTZBdsJq5K+?=
 =?us-ascii?Q?VK8/X7uXgeHQn6O+WfesAhz8DrqhPa0dSiZ2t+nOU5Pf5xQPIbRlbnEzvcMo?=
 =?us-ascii?Q?x0spNx+4zAg90BKHFJ61hHiorqbIgR4Q1o9z+56GejuOb8A+o/tQASidTsAm?=
 =?us-ascii?Q?fpVl1K9u0DIntTnoD507jd2tFpeNZBjuWwsyZf1p/1j7GfoaXfOyAMKCZq8z?=
 =?us-ascii?Q?3jyy9xB2kvS+35VNpCo5jVnJX4c+igeO75LQ4ldKiWW/?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049300b9-dc90-4bfe-9290-08dcc71fac85
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 05:10:03.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KhSrFEtJtAiC0Hpmzo4alx71RFd2fZ0463oxTW8xZyq4HUcjln4bEl+kZ3a12DHvQmfmrIWOxIu56qM3s6DflKe7+NVdIJxB+tebrSebBQaeOo+k3DortgvBWiYCXr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6506

Changes in V4:
  - In trace-event-python.c, fixed perf-tools-next merge problem.

Changes in V3:
  - Rebased to linux-perf-tools branch.
  - Squash symbol-elf.c and symbol.h into same commit.
  - In map.c, merge dso__is_pie() call into existing if statement.
  - In arm-cs-trace-disasm.py, remove debug artifacts.

Changes in V2:
  - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
    checks per Leo Yan review.
  - Updated mailing list distribution

Steve Clevenger (4):
  Add dso__is_pie call to identify ELF PIE
  Force MAPPING_TYPE__IDENTIY for PIE
  Add map pgoff to python dictionary based on MAPPING_TYPE
  Adjust objdump start/end range per map pgoff parameter

 .../scripts/python/arm-cs-trace-disasm.py     |  9 ++-
 tools/perf/util/map.c                         |  4 +-
 .../scripting-engines/trace-event-python.c    | 13 +++-
 tools/perf/util/symbol-elf.c                  | 60 +++++++++++++++++++
 tools/perf/util/symbol.h                      |  1 +
 5 files changed, 79 insertions(+), 8 deletions(-)

-- 
2.25.1

