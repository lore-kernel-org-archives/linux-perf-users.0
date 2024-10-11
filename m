Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020137.outbound.protection.outlook.com [52.101.61.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E191885AD
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667061; cv=fail; b=QY8t8YTobwk+uCsn0i3hv4EIAnzfUueEfe8LGs1fDOgqAn6f4UftQQleurRrgYkYYeTf3PdB13m7NCbB9FnvdrEudCAco0srZM2y1JqqkEY79NoSm4IHb3njIsv6w366VWTPY2bnkiieqPDpTNGjzziSpWWdjUZcQld4OXX/ynY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667061; c=relaxed/simple;
	bh=9uTmrhQjv8lhiwd7WbWh3n6yhxanKAXSz2uMemV18j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/4OheW71pPBvkI070FyCQVQHHh+CaDgySg31uDKo18M9e0P3aUS0ne0mEd1uOloBFRWLAbsWIjFJosGJkNdPQUbkvMElcApeQaYPrZ7JqSAccAMKWkjtd+1JyNRSKnhg2cG+tE0e6g3SILlKZsP2j4nof25JFRRupT2BWtqNp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RUx11BTh; arc=fail smtp.client-ip=52.101.61.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RUx11BTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQB5y3vSAt0K3+PbC8nZ2MipLzLo/QSQJPLekKQ1uMAfs2Ofo+b/KNBMiHTQqercXAcolkuXVKY9UKGub0NQJGMncfBkJvRisfatYcujh6WE9hGcy+a3VJtJt3zGuG+rc1cRhHOykJWcxqJTM6jdL7z8wqMWJXe8lDVtnnwbqnIdTEUgHncTDSSaxeRBIBZs6eG3EOmMjtIxKkUo5mwGBWWB/LnsMiuXq58eug2KVmN5F7POLeOrGplshPkBCGXq4vGbWjgtEoicyZ2kYdHW/+9sqWCX+oeu2jB8JCnnj4Jj2+e/HCLBzjiaUcDwtAloG/Ack+8+ZvZ+v2Gg0wkpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DEw92mpbvvAFSQRclhbLrT8kKBotlHTwXEZrx9zQO8=;
 b=o8R5ATeJe6XMc+YG8EZfvElldw8mg52ZdlxXUqZP7Dllz2YI7am7HHAuDBvyz8yL3LH9cYx7IMitWt1/dYfm94MWCw3fzQlKxgsyAcUnVtAUNk1d7X7IkjZM/vIpO5VWNTCmr1OuZ8RATeHTkIYO7NtPOdQUdnvDqM0DEEWH/d+1PQBI9mFc6QfExIFagu3QjMXDabGoS8Zwqkr9PKZywUcVlCTwB746UJPygTndZ+VdDjcYo4oq8AQXnlDpcP1glxiBAKMuJR0l2rScfiCf6RrZQhfrH55WGpgTfcxW8yqX77y0eF5NsXoCOi8D7LNSQwr/wSsnh4GxcLV5IPZdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DEw92mpbvvAFSQRclhbLrT8kKBotlHTwXEZrx9zQO8=;
 b=RUx11BTh5CQs8O/nyaFMBOTEwKSG/gX9NPi5W3JPWs6VFppl8RzV2tKQKwkit0qScdf91e63+vW4qB88ZWHTbqcHth76xfgfsdLdB0qYZCnn2yWDDEPJnNLfCyYNmKkEK68EvCEr+pnwfbrsVKoG5gLf+nlounvV0tpODP7SqGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 IA0PR01MB8306.prod.exchangelabs.com (2603:10b6:208:480::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Fri, 11 Oct 2024 17:17:34 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7982.031; Fri, 11 Oct 2024
 17:17:30 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V9 0/2] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Fri, 11 Oct 2024 11:17:10 -0600
Message-Id: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:610:118::13) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|IA0PR01MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: c461d289-a722-455c-6f42-08dcea1896a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qN0B6hA/I9qOvi/b/gKZLId2v9BFv0CMyBeZqLuiX7sn2SGQYd+mphDHaLCz?=
 =?us-ascii?Q?yQjSDnLX236am5RnTSFyw/EcAIBm5JpKnuhCMYYwORavGVWPCpTtMWs7FtJ+?=
 =?us-ascii?Q?wtYOiA+3N8LmCEkw2UAnrw7ccV2/xMg9hxipZ12iyQ+3XPwT6H1HLrEDpTZq?=
 =?us-ascii?Q?NfQRqVE3gNcrce3iZK8CoiF5ygdmTEeLsGmPzSwsYq9zPcVLiP8TkHkhMziA?=
 =?us-ascii?Q?zWFeLkvr5vFS0MyRW4L9j3cIsxzS27Fw7JqwB7LwVuiO7YJgJeg9Q4dmmYa8?=
 =?us-ascii?Q?x46JFfz+n0oFGW+cjTmuczB77DwBm2oGusvXZqBf1UguOubHozDYIVV0Sw30?=
 =?us-ascii?Q?jDTq1PXC+batstXWTDOjcCRMHuNYN3c3cGlewLdm1uFeNMLxS5lhCzZ5GCwF?=
 =?us-ascii?Q?4MuV378jTfyaO6Ure1HEo+9YbznHSs7sa0Zq44nPtKhZX+A0g6upTTNiB7mb?=
 =?us-ascii?Q?/xy2hd2299hb1VK42Ju6dqfWmLtnEHbeRYYIU9w+8weq3G6mcBwW0kmAWMQi?=
 =?us-ascii?Q?pBMWAlLz8fBYv1zQTVYo1R4S1xzmw4JxneJWnzYU2oC7eTgn+iVRV+9Ixpg0?=
 =?us-ascii?Q?vp9mUQf+w9DNi9hypCVqBEk99NpblkKkZrPBsg3rZHkl3etevRjimxUZKhsb?=
 =?us-ascii?Q?UsO7+LjR4v6tr7HbK1TYWihS7hy6Wz3oU0VXCNYs6v1V2MJcUtIhfs1TIBgI?=
 =?us-ascii?Q?EgU69gqkYXYHydbwDiSdr+0rXlagIy4S2YZwNYimqeAqDcI2fii2Nce4M7r3?=
 =?us-ascii?Q?tJSllfY6Kt6oklvoDY7ETrHNjWW0ijOwwlaNQJYTSidI56xsdkRhXLZtKnpo?=
 =?us-ascii?Q?KtgfYqGcKh7GKRzS8JIUyBTcSGURUTiYPHO6wkyRjnrLOnL/X42KxtdEcKoD?=
 =?us-ascii?Q?fB/HqZjGqlMl8aGLDVA6h/Hby17tRz7R+B9u0JhbnGJNmdGXnpU+klICvWwj?=
 =?us-ascii?Q?s7NI9KxoZWTzUItt3kRWT8d3dqJUh199Any2kisN+eOjhX7+AewNTwv0iLfn?=
 =?us-ascii?Q?AY7ArPP/bm7d6I9ek5JGY6SxB4d1DFEuKSKcxVovsSPIc2A7syKIfy8lRAKQ?=
 =?us-ascii?Q?sFojce/27zbHO5a/da3kYwJDaLkqSrZy5m5e/76VfQmpRXlGGYuTlEHI8DKq?=
 =?us-ascii?Q?eIeY222saIqb5mX4wKKV4JmGxOkC8/n6kRJ7rrxa1DtbWG6HyxSwU08VqSu3?=
 =?us-ascii?Q?MqUGUOxzEAxy+LO7LWJ5CmurJ4awLMLtIz3luCXEPHB676iLab2akS/38VLF?=
 =?us-ascii?Q?7YuCHfGLrvk50dhNRut+7F2GDoUMmXruSIfY3lYMDtTe4796PsqTHNLkxwAK?=
 =?us-ascii?Q?wOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UluqeZoGAqSEUucc3i6YLufr7Up91vbE4Q7NTuTUArZSP23fRz+1wXKBjEpO?=
 =?us-ascii?Q?yf1y84uZ6HJ4mrSYWlfu93AhVpNJN+kCf8p74QT3/UW+rkO3y8A8ZS4MSEXp?=
 =?us-ascii?Q?7dcY5YwxM9KjRf0ONRMFhDdUGt7e411Fb3lrK4OnJvNpiEMH0jllJIya7HMl?=
 =?us-ascii?Q?ZCLwMAK9IIT7kRCXKjOxF6P+JPGKeUJvylKsfMYa7N4D/XZ8Q1WU1TtBxsnv?=
 =?us-ascii?Q?MQY444WCYijVhXM9+INzp9NJT8tUbX9TMYn+C54dZhkcGzPqZdQQl+zh4FkY?=
 =?us-ascii?Q?z9EgAP9tEva/It3wHpgOUhWRHVE2cvPhQwNTlJtDbobUgTPBSd9DZc2dSB7v?=
 =?us-ascii?Q?W2XLTThWKUxfrgqNozaBW+mna1O0c6i0f6AokpiV7XyUAPJ/t5CVQP6MUi8a?=
 =?us-ascii?Q?fhvdv2CpqFZ3l35/rvD/eCIEUarhbya+MQGhpNeTscLM9CE2EMdMqOzLP7Xw?=
 =?us-ascii?Q?LNwA8uEdypot7YOpQNdw3nJD/THa99fdx1/3z31IHIeLM4Mt+lXvZ+16jA1Q?=
 =?us-ascii?Q?i4Afuk7mVl/K9LmDwnTGg+csKh8Zgnqg5/XgGvhHQX5KTZEs4Fai7AbwX8mq?=
 =?us-ascii?Q?RoO8X+aH4cSvZeKYBqMp8ic8XDBDkIpk8jqQ8yxUSBwSeVXT8bUtC9SwU9HL?=
 =?us-ascii?Q?Dvlqr3fAxMstJn0J/UhQG1lAso48ACNfXr+OKDfwv97NHKeHrv6AO3hbjKmB?=
 =?us-ascii?Q?slcJHT8MyzmlE93AocQw+JmBE8ykrIRBIgvZcZ1XY01cUmKgBxtymxeOU8NX?=
 =?us-ascii?Q?6aZ7kvkWTYIKswipADeSj3m1JWQ/CJU9PZ8fZ/hJnbXpFjMt9Cd5l4Kwf5qo?=
 =?us-ascii?Q?IiS7lQkyEgkHZL6vEn1zHv9qxNAHHXx3GSIBmxqaZhIQVSVkIaSkNRMOPxQa?=
 =?us-ascii?Q?P/33+uYraRe4TP8LJf8rkFj3pso2xJ11fqlwsYU/+CTrRntOvwRiaUsK1qg/?=
 =?us-ascii?Q?EYo0RVbz6N8jJ9BkSsrkW4yMJ6xaFSV5zlrM4RU+LuZvvWkHAGJ8BoHv2IKG?=
 =?us-ascii?Q?a4gqv7Vokp/GfvJ/u0sOvOFTNyZdmOZD/CaQyMaoQiNq1PxBUPEkjXAWYhR2?=
 =?us-ascii?Q?Guj/beEwduxtBLD6sCCF56kmjAZqq0NR03eylfNSXDMERT76dAKJBIf7jCxn?=
 =?us-ascii?Q?AlszTH4XJBMQLoeKDaq8t5gwsCVbSTetmwMnjJ7FwpD2+LkvBRiNfi6XeyUE?=
 =?us-ascii?Q?lxNrT1m1LO2GEU3VD7vgDTLn9jqEL1LJjVO7PBwi1ZKPAfoIBi8odTrDyJmo?=
 =?us-ascii?Q?P3YPXBxMCIEau5liHtshzZHMINyzFKTQNIVLTfsW8Zgp3/v6h3igWNMQYR5I?=
 =?us-ascii?Q?v7VjimfLHZKJLDUc8uaO9q8fFf55HONl51c4wTBY30osf4L541ocs/1nGOAk?=
 =?us-ascii?Q?PTfy+5rrA3k18p+/4a5++6YQljO9/YKxM5OoF+9tNUi3EnI2kFzV8+WYGJfc?=
 =?us-ascii?Q?Yq24dej8wnfJ9kZJVnTm/DSYGjamA50lv5nSN3uQtq/wuEw6hFXDB/FmBR1O?=
 =?us-ascii?Q?lo6+ylXAuelxgQr2Ro7tKCcsq83KCjPQwQJEdHLLUDVO/fsRFK8zTSSGX6q2?=
 =?us-ascii?Q?NsJpFt4XInO4Xz1HSjMT9sZ7mhDHk0zCmZpSiEASSN9as89Wk11jjHPFE7Qr?=
 =?us-ascii?Q?BwJr1COBQIEJn2yW2ZyZ++0IYtnxVPTvYATQY34JD3V1?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c461d289-a722-455c-6f42-08dcea1896a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:17:30.8572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApCz399VyOhUrmCO7unbSm3FP4+zNXmvp57tFI1xVd1yURt6+uR1dzeANPQntN8DPWp11C6/o+bDeNZIVtSOIdZuWoT7lU3YzKFZnIRVE7TSKbY4UKBMUU+vRCquV/oh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8306

Changes in V9:
  - Removed V8 patch files 1/4 and 2/4.
  - Modified set_sym_in_dict (trace-event-python.c) to add map_pgoff
    in dictionary as-is without regard to MAPPING_IDENTITY. This patch
    file is now patch 2/2.

Changes in V8:
  - in arm-cs-trace-disasm.py, ensure map_pgoff is not converted to
    string.
  - Remove map_pgoff integer conversion in dso not found print
    message.

Changes in V7:
  - In arm-cs-trace-disasm.py, fix print message core dump resulting
    from mixed type arithmetic.
  - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
    CS_ETM_TRACE_ON message is changed to print only in verbose mode.
  - Removed verbose mode only notification for start_addr/stop_addr
    outside of dso address range.

Changes in V6:
  - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
    map_pgoff to start/end address for dso not found message.
  - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
    by Leo Yan in V4 and V5.

Changes in V5:
  - In symbol-elf.c, branch to exit_close label if open file.
  - In trace_event_python.c, correct indentation. set_sym_in_dict
    call parameter "map_pgoff" renamed as "addr_map_pgoff" to
    match local naming.

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
  - Updated mailing list distribution.

Steve Clevenger (2):
  Add map_pgoff to python dictionary
  Adjust objdump start/end address per map_pgoff parameter

 tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
 .../util/scripting-engines/trace-event-python.c  |  9 ++++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.44.0

