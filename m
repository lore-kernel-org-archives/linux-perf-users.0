Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020092.outbound.protection.outlook.com [52.101.195.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B2E4317D;
	Mon,  3 Aug 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761335; cv=fail; b=X1PllnoUG94CaOv7XnIIJRq4qn5S+GQisGCvOByHJ4LiwW0Asnz5tA6Llg6mjoreYR1bT7raELZhjsYWRaK8/jw5HyAI+2aVNX39b0+TRADdubAbdX9poccK4pLdRiWPFoiVg29dzVtP8Ji2XGN37ipx2y43+QS1DsoCjTrkeec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761335; c=relaxed/simple;
	bh=KXVIwWJfa4ZoFdZR/cZ0HXQLc4Sm/fCUQzIpEcUqJL0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=W/E2BQ0zvvykfaQqMfLQ6Vw3a3LvgUPZ18FaX94GQCIrYSyLMWEMv0W3Bc77CQpRGPajKykj5AtdQv7vY7LIAQ5br1w2LlVARyyAU/7cppd684QuWJhqgQBYZY7U/sQ8o0548LlueIQHU2TGYzwtuUjj6/TG7hvFC1sLwL0qepI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fqllc2G1ljWwqQ4eCNJ44Iv/p3J5WKqUU5S+raVI3l2Fe4749Q4QBht977kiYf0jL7q+LpLiUJNYwVRUlF+Kyh3WiKG8EF5Gvd18y6l/aeg7wrsgQyGNl2euxlZY7uqhZ20kAuWR/crwQyfcVh52GjTymqpo9dfxs2V0GJTF/N/IM1ClCb+gTIu6+4/KTLik17uhfbM0WPpYhKuSB46FUdH/yr6kb0wMuQWqWgMOoOji0MfRVxNq0yjdaa+EoyhW/woy3fkzwyLie6zUn3zAeXRTg7hH9WHj4Z77sFGvKDspsgSVrWRuNq/pr83U6G/T3BoqEENuqYPWB8RzkVHBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SXd0HUwTT2cTeiszPdWWeDza/DyNL3yjg7iDO5Mer7o=;
 b=q00szM4uSjMyYA4lDH8SychwNAUkFJ8WWpBxcx+kI4nwTdJuTR4pGlKg1kFLv0a67yl09OP7vH8QiEjRm8TXsFX432W1Y305aTmOmndsP+4apvXAev7Am6qCALioQ/JQ1ge+gvPKeuPfuQeAkyNtwpFLYB9SQVHkL4ZRNzxE7rDZASy81lWg3E7o6P+U7s8PJXJI1I8zm4jeBcwlcT4+lFkTZydSNqxVjz9hgYcSOUjcvQ+6cltrfFpls+AuCw3dEbC6sqyhwnj1iNJ7Prff8mCZ3g13KDhG6mzgZy9GDbyZ1zqWoDQD5MxxnxHCY/1H2PgODt8VrMGafQFQLzem8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB7556.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:48:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 12:48:49 +0000
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
Subject: [PATCH v2] perf trace: Format fields with hex specifiers in print_fmt as hexadecimal
Date: Mon,  3 Aug 2026 08:48:45 -0400
Message-ID: <20260803124845.213165-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:208:236::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c5bc67-6ecb-44d7-58ec-08def15d90a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|56012099006|10067099003|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MYvrvpRihRSl/7w2dbahFXv20e6tUqZnmdIpS/H4cqJygyYS0oiRVG7Ld30VADgjj9sl4OUd4iRfojfl7jVXbwr6RlQMASHQ3LOCbZY/ymScoepw6Am08V043SXDxRCqpvPZnWhaz7ZLaS3Lx0LM4slBAsQf4gkWp7vTMYqMv23GGNBwTQ/bggLDI3QkulcyupNZDN4veGHD3R87sAjYlx2qndxavEGbg1DZH5mS8nZlw5zEzt2lGP/p1/dluWRfNZ5WIU0pQUnVMjv+XUeofRIDPFQW0Vld2Hu37/wfFRCA70hrFSdfCG/FNHhgapFpGIypPHlKczzJRRva8LVGiyKq9z0g7z891tEcJOkh7i6SwTFXmydm7liW8kEkoqr2mj0pOmSw33VXLaQkZ5WnyMOqkiri59KfcOwGOE5+L7gcwrkK5vI43Xg8cCM2l9VjMC2zIvWtpbHPerghV/3MjEwH6Y3Y/rsZApZuTPBVaHi83dWGTaV4VoOzHtR0yRuF6whnLtVAILdc3fdkA/r7p69R6PcQY/GW6/ggLf3i/iihjnD1F/69UcA/oEUFyc7MvfiYN3nzKEqWrQdh48h2d3YUmFQooWKreRWfShlj1Cunn9io7npTLcbbdXtEZRp1AynhqJGSxzNC5ex0KWWyI9H382Q1lV4v830qvb3k+7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlNTUFdMY2ZqRUE2YllOdy9uTm5FZm9oYVFjelNFdXNqeER4aU1CdmVXT2xw?=
 =?utf-8?B?UWEzR2VBeXpNUUhIUjJHVVdKS1lJeGxzZXpFMmdJNUF0cDNiQ0I3RE82TGRm?=
 =?utf-8?B?eGU4ZHdySEdrQmM2MzFzQndxN0NTdnpnb3VaRUU5bzF5OTlLaEtwRWtsRkQ5?=
 =?utf-8?B?VGNSQmgyZDA3TjZ2YkNzQVU4TE91Z0Y3VXRld2JqMVRHaEpjODJ3VkVJZ3dC?=
 =?utf-8?B?WlU5M0h6WTBoaS9TUU1LVkgvc1JlUXNUSEgySHJHSzBoN3RaTEZIUERjRzlZ?=
 =?utf-8?B?TU9NbEZYVjRHTGFPZTNST25SNGEwd0s5dk9ZempuVkZPeVlHdUxIOHU3YWZh?=
 =?utf-8?B?UEYwNG5yQk9rVU9sSlk5WnU1WG5sT1hUZ29pS3Z5VTRrOFBUNEV1VEhGQ1Rn?=
 =?utf-8?B?c0hDV2ZJbk9iMzkxNzlNa3lWblhqMmlTVlhKekt4Um5lRURCTjRCbzZieVF2?=
 =?utf-8?B?SjROTnRXSXdXUEpESTlEbHdtZ3FHWi81TDg0bkZadWpkMDB6Y3lwZ2JRVnlO?=
 =?utf-8?B?ZnNvMUdjTUg3cHFpR2Q2SExmLzJUWlBIcjRuVGlHN1dzTUc1eDQ3ZzY4K1JS?=
 =?utf-8?B?OWR1YUEzZVpyWCtLRXFyWlZIM0tvWTh6bDRpUGpCU2lXVFAyY0NwTzlmelFD?=
 =?utf-8?B?dVBiRFFvSGZHc01CN014cXBTRkdZY1pLRURNWHJOMVhZL0lydFJMMnBLSzBi?=
 =?utf-8?B?Wkk0YmRTeDlUcjBWcm5tNmZvVXMrUXRBL24raUZkWHRFWXZOOENldFJ6UVY0?=
 =?utf-8?B?bENaa1FHNG8zSyt4VysxWjk4Y2w2OWpiNWo2OXpqQ3duREo1NlBHNjQ2Z1Ez?=
 =?utf-8?B?YlJYZ0Z5NVMwRVJ5bmU4YWVpOG5yMEpYLzc1WGVzZWx4OXhla0didWxDbmxU?=
 =?utf-8?B?c3FaS2ZteVZ3YkNlWnpWSnBBcG9SdzhldXVWbVRWZ2J5WmFTelFPZm5zWFNu?=
 =?utf-8?B?YnFMWFg4ejhuT3FDQ2hGQzk0VGFHUnlUOUljTUhkNHFrZ2czSmRKdWd4MkxH?=
 =?utf-8?B?SEZqWDdQd2tPR0M1b3liM09IemFSd1hOZUFIZ2tMVDQzci9SZDQzZEsvd0kv?=
 =?utf-8?B?dFFIeElhWUN4UUVtRW9VS2RHMEdsTlZJdXhnVzRSUmhUMXpIOGYzUTFYdVlR?=
 =?utf-8?B?SHY2NG5rYWU5UGd0ZTlmWTgxZlZQc2dzRHJRdVV4MXlnK3JZSFdnM3oyQnd5?=
 =?utf-8?B?ZEhkdElGSEZ0dktONERGQkxCby9mbTh1RVhmOVJyUGQvVHNiSG43T1F6UWwy?=
 =?utf-8?B?TGx2cFNZZG5kb01qcnlYMTZqcm9XOE1WSTFrUEZVRUhWb1hDNENodzlMb3Va?=
 =?utf-8?B?V0JlaTR6RkMxdGc5eFNFaE84b2VhckcwTEpQY0gwWFpJVnBkZ3NCL1FlRys2?=
 =?utf-8?B?WFR4aDZtc1cyelBlRUpZTVZJYTFVeHh2NkNESlU0TmJWWk5ZbkIzN1Mrczk0?=
 =?utf-8?B?UXByMGdyVUNPSitLOFhDK3F6cHpjZ2dxdlZFR2V6M3REZHBncTZseER2UFRU?=
 =?utf-8?B?RnRhZ0E1cDFpWlkxdUU2TFlEanNGazVvaWVydk5yQnNiV2crTGx3VHZXaFdV?=
 =?utf-8?B?V0NRdGtobU81M29OdkFvbkhEMEZ4UzZ2akpnb1hxN0dvU1NxWVBNUUVjQTJ3?=
 =?utf-8?B?TmJyQkQvYTg0RzQ0ZXhFU0tOUEZhdEFxc0ROYTRYSC84Z0Z0RktVQ2ZrYitn?=
 =?utf-8?B?enZlOGVUQUVDcjlzRDZtNHV5QmdkZ2ZHQzVsa2N0WDVidkNOa1BMQWRpaG5Q?=
 =?utf-8?B?bnM3OGttZUFOOFd3MmllWkdkNENjY1JEQUV3ZGFGY09OUWVUYWFjU2lSTVF2?=
 =?utf-8?B?NHdycVp6WGR4WWJyM1k1ckk0YWZVTHNxTjh2ZGRVR2QwT2EweStWaVhXRllN?=
 =?utf-8?B?bURxdFg5Rms0MGFNZWFXZFRORHRkb0dwNER3ckRHSW5IVTIzVFQrTlNCZzVq?=
 =?utf-8?B?eTN4c0JsVVZSRjhIdjBZelRadndkTGh4VUhBWmliQzZiaUFROUo3UkN5eUg0?=
 =?utf-8?B?OUp2L2pCaXFqanZhLzErcWl6b1JjQXVaRFNmM1Zod1hjcWZCcmluaEk2NjhK?=
 =?utf-8?B?QWRYUmxPOXBLbUJRQ1hBTitsSk1ubk1rY214R3piektML3pQRzVWL0w2aWRG?=
 =?utf-8?B?OS9LODlZWmRnbmxHY09sMUZ0VUJrdWN5Z0FaZnd6ZnFoSEw3c3ZRT0l2S2Jm?=
 =?utf-8?B?aEJBMk5tVU9jSDBjMUwrUksyRGd6bE5mTFUxY044bEJiQm42LzdFb1JIcWt3?=
 =?utf-8?B?Z0xQRnZSVGRwRS9DREZnRURSYlEyZ1N2OHB0Q0RaNjZ5eTV2U3FGMWFHTGZF?=
 =?utf-8?B?ZHF4eWt1Y2JhQ1ZsMHVrUmZnb3g2VWtPNGVjTzhFR016cXdNeStzQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c5bc67-6ecb-44d7-58ec-08def15d90a0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:48:49.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hQ5jqPuwb37VV52R2QbRnZcWwABPmpYJzdbg/hOCpZ30U2leQ1KSX7gPbtw3mgcpI64JuMZWG6LzRCTLQQLuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7556

Currently, when a probe event is added using perf probe --add with a
hexadecimal type cast (e.g., var:x64 and var:x32), the kernel traceprobe
subsystem sets the field type to "u64" in the event's format file, yet
generates a print format specifier of "var=0x%Lx" or "0x%x".

By default, perf trace uses its internal beautifiers which only inspect
field->type and field->flags. Because traceprobe events declare
primitive integer field types ("u64") without a C pointer asterisk
(i.e., "*"), perf trace defaults to printing the field's value as a
decimal unsigned long ("%ld"), ignoring the hexadecimal intent.

Introduce field_has_hex_fmt() to inspect the tracepoint's print_fmt
format string. If a field's print format assignment uses hexadecimal
specifiers (i.e., "=0x", "=%#", or "=%p"), assign SCA_PTR formatting so
perf trace displays the value in hexadecimal by default without
requiring --libtraceevent. For example:

    ❯ sudo ./perf probe --add 'enqueue_task_fair rq=rq:x64 p=p:x64 flags=flags:x32'
    Added new event:
      probe:enqueue_task_fair (on enqueue_task_fair with rq=rq:x64 p=p:x64 flags=flags:x32)

    You can now use it in all perf tools, such as:

            perf record -e probe:enqueue_task_fair -aR sleep 1

    ❯ sudo ./perf trace --show-cpu --event probe:enqueue_task_fair --max-event 3
         0.000 [000] :0/0 probe:enqueue_task_fair(rq: 0xffff8ac632233180, p: 0xffff8ac2c1240000, flags: 0x100009)
         0.006 [004] :0/0 probe:enqueue_task_fair(rq: 0xffff8ac632433180, p: 0xffff8ac624cf8000, flags: 0x9)
         0.069 [001] :0/0 probe:enqueue_task_fair(rq: 0xffff8ac6322b3180, p: 0xffff8ac4c4212c40, flags: 0x9)

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v1:

 - Fixed field_has_hex_fmt() to properly handle escaped quotes (\") in
   format strings

 - Link to v1: https://lore.kernel.org/lkml/20260731215909.125335-1-atomlin@atomlin.com/
---
 tools/perf/builtin-trace.c | 46 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ba0f8749fc7d..5a3e043b5b72 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2098,6 +2098,49 @@ static bool is_internal_field(struct tep_format_field *field)
 	return !strcmp(field->type, "__data_loc char[]");
 }
 
+static bool field_has_hex_fmt(struct tep_format_field *field, int len)
+{
+	const char *fmt, *pos, *end = NULL;
+
+	if (!field || !field->event || !field->event->print_fmt.format)
+		return false;
+
+	fmt = field->event->print_fmt.format;
+
+	/* NB: Limit scanning strictly to the quoted printf format string */
+	if (*fmt == '"') {
+		const char *p = ++fmt;
+
+		while (*p) {
+			if (*p == '\\' && p[1] != '\0') {
+				/* NB: Skip escaped character */
+				p += 2;
+			} else if (*p == '"') {
+				end = p;
+				break;
+			} else {
+				p++;
+			}
+		}
+	} else {
+		end = strchr(fmt, ',');
+	}
+
+	for (pos = strstr(fmt, field->name); pos && (!end || pos < end);
+	     pos = strstr(pos + 1, field->name)) {
+		if (pos == fmt || !(isalnum(pos[-1]) || pos[-1] == '_')) {
+			const char *after = pos + len;
+
+			if (*after == '=' && (strstarts(after + 1, "0x") ||
+					      strstarts(after + 1, "%#") ||
+					      strstarts(after + 1, "%p")))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static struct tep_format_field *
 syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
 			    bool *use_btf)
@@ -2125,7 +2168,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
 		     strstr(field->name, "path") != NULL)) {
 			arg->scnprintf = SCA_FILENAME;
-		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
+		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr") ||
+			   field_has_hex_fmt(field, len))
 			arg->scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)
 			arg->scnprintf = SCA_PID;
-- 
2.55.0

