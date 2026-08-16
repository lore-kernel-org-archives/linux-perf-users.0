Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A43D300F;
	Sun, 16 Aug 2026 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913977; cv=fail; b=s7a0xCJhAQYcQPq+TgLLBmwMkFr/3PBgryxXTm/5WVV2vDYJkdF6oBchOuAgJf3Og43/mx4+MRPvfpoTKSSJAhERhdkWVbTDrYLR5Lb3lQC+TIUb8MEQ8hKsIhoJDp4xSry8YnJmunDiu44ROLE29Ud6BaMV4WZHkvJ/WOIdLMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913977; c=relaxed/simple;
	bh=GVgKO3P6BpaGDNnLxbWKGuDzUbD6phg67vMg29khpy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpRb57aL1Tza747QrLSIUYT+8oRIqGHg4NVmcdS1i8emgbTUWHGzreKUqoW7OhPEkXO2rVBQlwq1Ik/6J1NtAg7AYxxmITtP3FBGG8UZSjs/5ZrkxnkU0RwZHshjyqDR71HJ+JpnqTj3mRCNAJtqF9AHO/IXkypqorOpVbHPOz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmtMo22gv33e3dIx+nddcGWi6e55ri5kgH4GX8TC2af3BdQqj69OEkdSPPs3FoejMh+eSiOFy86zOAXOLOnfHWH/GIJnOmFJVtMXoi/GBDUNHFYuxFqcmmiU3ObDngLWHo8cVJ5ox/lezDdViy2Dk+zsmHb3lt/gVVfQJRLHu+RI4dOGNkpKrRR76wlNXihWfsn9rnetKcOWXvJJVY0rktmX5kARdmIDLbyM2lXXUl6RMw+4b/U6o74qLNSrSiYSW7p5gUnVs8IUxin+oBP4GsHTuvvgvO/vAOT4RurgHEdCr8IGe+o5sqK2w5bkwQjZhXAAaSeuLOFYDI+1hoLSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=MlnSBGjxPrFqwflqDgOltvRSK3YSTPL1JmdjVEwN/tE=;
 b=NFYjLWWLwyt22lkmDFWMTtvmDzz7CTry8FSVKelL1HHUkvsqxc/wZ7jEqsQdzGKtcdfNO297meK/zPKpnUyUb9rK2reQlOpZ37leuGOcEsTFblOUlQrmpZ+xaIX/9dhq6oHziLuRhQ9Bx+ILvbEY8iWu1gUUFa95lcfjjntEDGCgxtm58/sWnqNlNDWSOFRb8hUu9FR+V6f6qM7KDRi+tkk2ADWNUSOVzoh/okJvTKY6dv6yZ0OZWfPJwyGBlkMBC8n4vtlqWko5sSQLD/4W4HRPLgOvbYZM8hpUiH0emb5zhPYY0HpialQbdPz8wtM45eP7OBnLQp2YDdHF6iX7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2682.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 20:59:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 20:59:32 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v2 2/4] perf trace: Auto-assign kernel symbol beautifier to function pointer fields
Date: Sun, 16 Aug 2026 16:59:19 -0400
Message-ID: <20260816205921.576365-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816205921.576365-1-atomlin@atomlin.com>
References: <20260816205921.576365-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:408:f5::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2682:EE_
X-MS-Office365-Filtering-Correlation-Id: 57975589-771f-4369-7306-08defbd94567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QDZMpEJ4Htn+Se5+wqf5p1GnvQwGEGBHJLUKxkSw+iGh5ubsCPrKe6JC9rRlY4XNbUMYAK75JCMa97wZ5NKamP0atvpwMc121LVgvYa8ATx9Cm9M7zf7Kr+5EDEIv1fLpnnF1fUouINV5z2OEajqDtCKK3Y8qUHTudveZTA+MhfdyXcyNf0MKBeFmMYPH9a9OS/k2vrHJX9KIP3saI2+mRHjDY0Rk1pJzZq8SQMPfD9uehnLfPmyskOtCe3nlC0DHM6WgiKI8UtK5bupsPh3P2yivgOt5CxLZqhJ7uBB5L1ABmCzgNPVkunSMP73wwVv7eRrQUSQq29CYHNDcETuKO9mbRGLSNE6Ol29qJZfaNJfuLN1+Yd4T0oHO2u49truHX1wbpOt9iZHjwGYHTKIWD+hHdwNnxK5xUuy05ajmqsJn1v05kyFx+n9WIVGh9WzNdQ+Jzhf4KgrFqBVbgTlFqzgHYEPTWz3uE+P0D0KVB0dA7dcgGqPAM/8mCGxx4VlKQ0QJrekLsBo6FTMjNT/Bs4hdXV/P5nGVcDlw+JTpstrAIwKOnqCMajt8xwF/5zh4CDsCXlevhrfz5iBTFpzPXHn7Tf51+Z5PnTYVIWPj8kAYdRQ8rKkdNMkM5HfZjFxs5Fabts/HnCp8r8kySfssLopDZC0MJ3LTsQ6gBLUa50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STgvTzIrRm9HczRLWWt4NWY4d3pTMXhscUlzeWJsc1dHdGdBd0RGZlF6WU4r?=
 =?utf-8?B?Sk1mT1BSTG0weFVpbExNemZZTmEyTEEzUSsxSGhhRlNUenRLTmU4WEJocllz?=
 =?utf-8?B?dUl6OGJTbGU4MGI2eWdIT2hxWVNMZGpOY2lLMXdHQW10S1ozbmxUYitFQ2FX?=
 =?utf-8?B?c2lmbWEzV2lSa3AwQUh6cW9SY29VanowL3FteEkvWWZJelp5eXJqNHJkS0U4?=
 =?utf-8?B?ZWNSRXdBOXdNT2VuendCeldzd0VGMjZRUGpKbjZmN0ZXNjAxaGRxbzJ2MmpG?=
 =?utf-8?B?TFpXZUltVnMxODZkNXZZSFFLczQ1Zndncys5TnlEbk9aQjQ1d1ZlRDRSdzlm?=
 =?utf-8?B?ckZXaFJxZm9NSmdWbkNVcGlyL3V6Wms1dW55RDMxb1I4V0VHQTRKbVdkb2ht?=
 =?utf-8?B?Y1NYNDNQUWlOdnR1SE1vSFNsKzhkVnNMMTh1SU9NZVBiWDZYNTRKS1JBMVBj?=
 =?utf-8?B?NjI3RFRzZ1MyMDhhemV3MTNWc3pxTnBrelVaTjVGWDZQa3c2SlNOU3VDWTRr?=
 =?utf-8?B?U3FJZERVZ1VzMzV6WnZjcU9NWHI1aUpNMUN5TGtLQ3o2QkVNS2NQTWVpbXVD?=
 =?utf-8?B?bU41MW9iOE5zWXN2bVQzMEloODEzcmdDQlVKTWNpclRwT1REYmVSa0Y5dm9t?=
 =?utf-8?B?d2FwUkwrUURqdkdSWnE0RlF1MkRYQUY5L0h1L2d1aWZvZ1UwMUlseEZ3aEdC?=
 =?utf-8?B?MVNOOGZaS1hQNC9zSXpHQkM3R2dPZFhpTmoyRk9OdURJSld1djA2MmV2OVgv?=
 =?utf-8?B?ckc2dkF5ZXNCcUVESUlJNjk2bWgzSmprck1DZmlaa2crampWeDNGZTNJMlBs?=
 =?utf-8?B?aS9vMVhHc0U5OHRRM0t4R241M1l6cVhLUS9lb3haUWp0VGM5TWpRRmJ6MTZn?=
 =?utf-8?B?bXNoNUxFNUpDWGo3WStwR0RZUnBLakdIYTdmY2V6SXZUUmNzRC9lT3o4Qkd3?=
 =?utf-8?B?K3gva0pzTWFMbjNCZUhkalJWYWc1KzJnK25nVGozNXlVTXBKM3BibHZaZWhM?=
 =?utf-8?B?SnZIZyt4MVFjWXdYMVY5elRnbEo4aDFRR0NHSzdWSGhESkZKbWtMWFdEN2d6?=
 =?utf-8?B?SzAwRFloZlUwM0h3UXJuY1hIelUyQjR4OE9TeE5nbUJOK2tjRXFmVXhMNmUx?=
 =?utf-8?B?UG9WOHViUkpRc3F5TFBLaUI4UFpsTXVlQUZwbGNSVDhFdU1sRzZWMFA4WFBB?=
 =?utf-8?B?VU43cEZxWHpzQmhtbkpTYXI0bExCS1JQZDBWVUpIRE5kaWIyS0hGRkFSdndr?=
 =?utf-8?B?QkMxaUR5NUNaQkdNUm16OWtZSDBlREtUYWVFeHhXYjdYQjlmejJKaDYzdVRS?=
 =?utf-8?B?dmY1L2ZTbDQ2Z1pPL3ROSkN3MTR0Rk1XS3l4dktIeUtSVHZpUmpCcm83Vnpk?=
 =?utf-8?B?Q3F6MTZ3SVYyZUo5eUp3eGtXMDUvK09nM3RRbDM5NzZrZFlFYzNsQTE0em44?=
 =?utf-8?B?UHVWYlgvY1VHZS9oNXZIK2czWVJoV3FZUWJmSTA1bUVPckwzUXdpSS9qNWxK?=
 =?utf-8?B?b0p6bkdpWEJTb05KYW1oWUhYTW5ZNDEvck9FYWFjR2ZqQnhZTmtFQ0dFQlhJ?=
 =?utf-8?B?T3I0b3RzQkcweEg0T2dwK2NPZkFmOHU3aG56Wk91TFM4d0VVd0xvU3Fzd3hx?=
 =?utf-8?B?V2FoMjJsY0ErT0VNMjdTd1pQaUZwTzNiM2YwKzBydFNoQXY4T2tPdDBDMmY2?=
 =?utf-8?B?cFJFVG5nTnFGQXE1NzBrcjhQNXRkeFVmV1RNUUllRUE4QkxtRFBZdU5FRFlF?=
 =?utf-8?B?NDlnaCt1Z3RwQ2xUZ2pMSkdqMlZNOGZxcDI0OE95V21rbUNodUhyYmpHR2E3?=
 =?utf-8?B?Nlg0Q1p4bXF0ZlpXbnF2S3RWMWtOVFNBVlFQU3hMcVcxVVN0eTB0Q3lSNTFL?=
 =?utf-8?B?aWFSU1g3K1NaL2gzdWFiMkEyTlpCd3dnVVo4WnBUaVovZHNoSDU3WTloNUl5?=
 =?utf-8?B?SHVOQisrVGVCVml0em1KQWE2dUY5Z01HTGNsZi94bEpDZkZUeGd0MTR2WDVp?=
 =?utf-8?B?dW5JaktNY1c5TVRlWG9jZXdCRnFKWDYwZDZUL0puckd5R3ppNllUQjlYNWJ1?=
 =?utf-8?B?Ylp0RzBIRWxsTi9YeENoZkY4SGhJaTM1aG5WNnZTbjdBNWtuZm5WeXFPZGtz?=
 =?utf-8?B?SG9kSGVCYytLMHFHbDJrdXZpTFFwUUl3WWxwRW9oalFxTnVDL2planNnWXN1?=
 =?utf-8?B?TFNVRldya2huME5yRDdZandnNDk1U0V3cjI2c1l5QkhhdXRKNkhDYUFDU1JT?=
 =?utf-8?B?RWh4QlpTSjlybVZaYm9EdmV1ZE5oTmg0QktFRUd4dDlsYVhzeS93Q1dRSWlj?=
 =?utf-8?B?RFdOTXRQWCtVZkZNMDZZUUltUXhkQUZTV0MwSmdZZ0t1SERTeTc2QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57975589-771f-4369-7306-08defbd94567
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 20:59:32.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pCkTh4Hq+RyMKy8HQIy22KYxjRYab7KdCYRjbsO32yuBku69rCtrlMo2jweQUkRCD79F/04wwru5QggRQrrqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2682

Tracepoint fields that convey kernel function pointers, such as "function",
"fn", "work", "action", and "callsite" are currently formatted as generic
hexadecimal pointers by default.

Enhance syscall_arg_fmt__init_array() to automatically detect these
fields by name and type signature (e.g., typedefs ending with "_func_t"
or "_fn", or C function pointer types containing "(*)") and assign
SCA_KSYM as their default beautifier.

Additionally, register common function pointer field names within the
sorted syscall_arg_fmts__by_name lookup table. This ensures tracepoint
arguments such as workqueue:workqueue_execute_start.function are
symbolised automatically without requiring explicit per-event
configuration. For example:

    ❯ sudo tools/perf/perf trace --event workqueue:workqueue_execute_end --max-events 2 --show-cpu
         0.000 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function: toggle_allocation_gate)
         0.132 [000] kworker/u32:15/236682 workqueue:workqueue_execute_end(work: 0xffff8ac2c1adc010, function: flush_to_ldisc)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 003048946503..85abae09d328 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2198,6 +2198,15 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
 		     strstr(field->name, "path") != NULL)) {
 			arg->scnprintf = SCA_FILENAME;
+		} else if ((field->type && (strstr(field->type, "(*)") != NULL ||
+					    strstr(field->type, "_func_t") != NULL ||
+					    strstr(field->type, "_fn") != NULL)) ||
+			   (((field->flags & TEP_FIELD_IS_POINTER) || field->size == sizeof(u64)) &&
+			    (strcmp(field->name, "fn") == 0 ||
+			     strcmp(field->name, "function") == 0 ||
+			     strcmp(field->name, "callsite") == 0 ||
+			     strcmp(field->name, "call_site") == 0))) {
+			arg->scnprintf = SCA_KSYM;
 		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
 			   field_has_hex_fmt(field, len))
 			arg->scnprintf = SCA_PTR;
-- 
2.55.0

