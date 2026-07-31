Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE433314B9;
	Fri, 31 Jul 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535161; cv=fail; b=BZsz5U0dd/7tzmGcBkRTSswoLYV0n90f7V7H3Ze8fuMjmDPcouKchE4sD8xQIZEp+SrlQpwMKe076vB4USnRia6+kIuvnUi4Ndskk6oUKrUiZR4q4Tp6+0ZJDqC+HUVA+Qq6WM4jKVezDkvz7353eq8pqtzGeTEv4TjqoJ2kBCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535161; c=relaxed/simple;
	bh=oCxo1T8IqMHUECAzLzzlA6G7NWGZzBWjhc3TFVXstR8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ghX3Vv5/hZSaGniAb8jY1ZqklFBJBplZaXeMkOACzBHO6evsh1pETZ66WdNle+N0Su/Ha7kOfSbuVr5s9nRiy0zjAQEs0H4IGhfymtpyvyNqEI0vN8cNwOveQ/FPRwlkKsqBpeOwAXtGvVHDyb1uNwTpCDZobuCQngCG+8Lel5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6BlXUl+Iygn/YGmgf9BD8i9+eGHRqBd2Wn/h/6srhKA7jx3I+SoCbvuFRWStjDbysxcvFcw/52BSJXkCzPSw7V7+YygVvQLCyiZBe5hNgCtfY7hte/vq12N1qL4vn+qcQlsscjJjItzx0VaylmtPE2Tsqy/uO9NzvJPe2GYqKD0ksj/4aEgy1yOiXF6r5ADCZTqVLmegon4n0J0sXB90K6azF/1QWu3TH8q9fLugEh9dVEjMQ398MQHlleYuy4ZAYmZPeZCBAuAHQCYbEi2U+CVsINFYifF1KZe8wemoRtbVY4GADxoozIR20+sS6rSc7C5I29zjCnwBWaTk1JcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=cwHkRD6G1bGzjlE5mZBDPEXG/Csm5tnxZMlgsRCRFvg=;
 b=hrfqRXt7Mcyc4z1OchJANLyzmRCEuuI7l8RPsg9aJagX9tzApPRN1gi3lHxLx3wD5L4ILBmP6mIJjnek+di+30/uT8wFRrJLx0y7HsgRQ2cXaR5mrA3o7AFxTMKqWpgtLsYJhTPWKL2rfTFgr1WUw/WYTnWAnjYd/7bx1fRkFgYdlxZ4eprKMBvIcSptcgc+t9trmyH/CWynU7+PBjyDoHXiahs03pVces84fG0jvAaQ6tiEBi9Nt1HYnW3QI+6MkOi3vyT+M1LWE8A6UvdHMSZ5mNgY2JeD+ZhnCq63Cn1myti4VdpWXszM4UGnHIvmQMhs4PxLXyqclzYie8J06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2954.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Fri, 31 Jul
 2026 21:59:15 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 21:59:14 +0000
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
Subject: [PATCH] perf trace: Format fields with hex specifiers in print_fmt as hexadecimal
Date: Fri, 31 Jul 2026 17:59:09 -0400
Message-ID: <20260731215909.125335-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0366.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2954:EE_
X-MS-Office365-Filtering-Correlation-Id: be6b0e37-2df8-41a9-cee9-08deef4ef5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|376014|1800799024|6133799003|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	8j+/USrVTy68UI4snjlJrytTw6yHOf5igPWSQ56NJLgALCQu+bBLrbMVXfMjw0f8Qr44WUeFaIPubrKqZbletoGQygWbXElZQ+UHdLNcXuKntjlsGAa/WYLxfU0yc2BlwmNMmDP/i5XYUpL5XAGcv1JC7Pg3o52WsJeCcesLX3EtKH8mzznKl2xJ4QbkxKs/I9xWgwjf2VTRkEZw600JiCkq/ZtxY0MEP8+XQ2aUyKwmXnxxzhKMbcI6OPftYbsm83c5K/jjidXTAMaLoBlupkN0eR+M0x7/VMjsZZ1YoidvYCJ1kScoDU0NUDZq/ssmgQxUuHlPBRYj/E4gQzDCwa4un5OVTgWkM+GTUFCdke2fQuffWjrNegMMrIulZnk5LOhppkT+XbXbVVfv/NEIFZVirvolzh1G7SZyjFCa+EUX1jfvlDuW7PrT/HPm25wN7RqifMJBM6CfkHfKtQIcrbvLCdEYAzNwFYOUetCXEu/2RBy6koQ0+GmtzKaB/obYhng9SuzS6XFQVWCfKELoP2wXjpXq4oosIeG1WKStkBO7LwG3JzchBpaHl3NJavX4bddB2wTqKdsQFfdRqPkH847fFnF+qOH1N+Bo2Yju88jpan8EnbJ2Cyr6NNLfmQ70cMH7wagZJVJW194lRthCsU7DYcHDbdNdQASU8ZbSC+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmxCSjllVTAvd2o4L0ZmV01VU0U1SWx3S3ZkOTJWb1ZQSjdDMStsSjYrR3Rx?=
 =?utf-8?B?TjIyS0Yzc0F0VUsvMm9sVElybXlSZUJBQTQzVVFsd3A4L093V1BUZ3BObkp0?=
 =?utf-8?B?ZGpmd2RlRTdDK2prVkc3WUZRdHFsemNBUWtXemdxMjNCVjRQb2UwYWVCNEda?=
 =?utf-8?B?TDQ0VTJjQ0o2d3NLREdTMm10bjhiNDBoRVJaKzAyeDFUejJWakZHUEJsZ3Rv?=
 =?utf-8?B?b2h6em1IakNuVDdnRjNQbHFiVHErM3BuQVpuSkJNcHcyQjVpT3BpOWcwajRJ?=
 =?utf-8?B?N21xd1RPeFlySXhKVUlSUk5WMndUeXdhNy9ubDlScVBpbmVCOE5hcHpYQ3A0?=
 =?utf-8?B?cm1CRERnYWhqcHVORDRZeC8zZUd3emVrdXBzWEFzQXNUTkFjUGlOa1lzNC9z?=
 =?utf-8?B?MUozRXM5R3J3TElFU09mUFZZWkFwNzM3OHphbFNZMmtHTVRqTm1EREJKbVRt?=
 =?utf-8?B?clBHOEVwYzE2UlVpNkVZV0wrMHQyOWRRbjNBTlVuRjhQTktkTk5WN01LQlVO?=
 =?utf-8?B?NTFwU1Y2MEtkaW1lY052dEl5a3orODdDSUM4enQ1NERYbHJpRWs5NmhKRTBZ?=
 =?utf-8?B?WWRoaWlvOGw3eUJVL1ErTmN4Q0cyYWxwR2pNdFN2VlE1ZVFkdEJpRzBmcldT?=
 =?utf-8?B?UzUwaFJmMTBSeXRhaEVtNE9jZDdCN0N5NmROYndEZmJ5TUtSNitWMFByTC9a?=
 =?utf-8?B?L3BKL2djNndWcWJ4UWpBMFVuUFR0S3IxS3B1cDdpcERwVDMweTF0a2lwdVZn?=
 =?utf-8?B?OVdocGhZWllnQTRERnIrWDlpSWZRamh5eHRjeEhVQVNKQlZmbkRpbXZVZi81?=
 =?utf-8?B?eElFTVZxOUlWS1JIY2J5Z1BGS2pSRUwxS3BPcmtJdlRFSXpwd1pCRVlUSG9W?=
 =?utf-8?B?amg1RkY4dDZJVjlNY0V3cndQc0haNStvazAzMkE1aGlCM0dQTkRZWmVhUnVo?=
 =?utf-8?B?UlkwZVZMR1FlOWRFcG5CZFhDSzBaYmN2QWtGZG12ZVI2Mk1qb3UxWnNMUVFD?=
 =?utf-8?B?ZjlYb1RISGNRZHl1K1ZmT3lsV2cyVnJqcjVLU3dDa3A5T05JdjdnM3N4bGtE?=
 =?utf-8?B?d0l0djVDLzVEZnJZVXcwQmlEMHNDL002QU5STlVtTExvU0ZyYjU2cnA3YlNU?=
 =?utf-8?B?K0tZblcxYktBUnFVSGc4VWdqVUdaS202WUthTkNQV0VTY1NlSkxqVnQzaktO?=
 =?utf-8?B?UDZISDQxZm5Tc3hKVFQrR28ya3BYNWZZSzEwUC9wNHVXeDNLQjc5WDVIYUl3?=
 =?utf-8?B?aVZjSlArb2ZiejkwMUFoSDFlSzFiUlgvTms2MGxVTWZwdXZLZW9xUWFlWmIz?=
 =?utf-8?B?M0JsZ3FlQnJuNmxlUlZvTHpJd1NmQThtelNhbEFmTmIyZjh3WWQ4ZHZoOU5z?=
 =?utf-8?B?R21qUDNpeFQ2MWNMaWxXTDZPR1ZlQ1I4eFoxaWZGL2g3UXlmeUhHU1kyUjc0?=
 =?utf-8?B?dDlybG9kWVc1NnliVDJlV3lva21oeXY2VWJLZFhhcGVwaWR0Z3hSSW5GZSt5?=
 =?utf-8?B?YWpxbGluOXNlVXNKU0tRbytZN0xZNkUvOTJYWXBoK0J2MjhkaXdKRDNVVWR0?=
 =?utf-8?B?YXZoeC81L1dVME5KSmJWdzRHWUppTEc5VFpJZDZaWUM5ZnlwNlY4b0ZyR2kx?=
 =?utf-8?B?ZW1lcnZ6aklJMGVJc2JEWnRUOTg0QVd6UEFPWjl1V3JqdnF4WkIyR1Y3ME02?=
 =?utf-8?B?MTNjYkw2R082N00ycm1xTVE4SmZWenNnaHFIU2RnS1d6a1k4dFkvWC9HOE1y?=
 =?utf-8?B?MUJ6Q0hBSTQ3em1XSXdFWlc1dXFCUGcvQjdCM2M5UlZBR0xNV2lZMVNwd1VF?=
 =?utf-8?B?cFBBSG9hMEwzVFVxS29xSzBIOTEydzlaSW4vZDFROER0QkVmWHd4YVBxejBR?=
 =?utf-8?B?NkwzWTFCT1hkWVBYOXdJVWowNFhCTVduL01XSG1VMEdRY3RBKzRjclREeDJX?=
 =?utf-8?B?QmJOOUJadlk3VDBnRnlxSzFpZDJDanZzVldaSmhpTWhaL3krTmVOWWRDdjcv?=
 =?utf-8?B?NUF3WHlPdS9jOXFZU0lPaG9RMEREZ2ZwVmEzQTRsTUJudG4wRDVHeWhBSlli?=
 =?utf-8?B?aC91L3NzYlRtL1B0aUNjcHFIVWlxdk1udmd0NnRQTG90aEExNWpmb3Y3em4z?=
 =?utf-8?B?eUh2NGpWMEZMUisrSExlNDl5QW41dmRrSWh1Z0dRODhvOFNmSlpzcjJQUXRN?=
 =?utf-8?B?VDY3V3l2anZUN2QwVFk4KzJURUVVQmZwZElFK3NBc0VPYjVQWEVrMkFVSFQy?=
 =?utf-8?B?dkVkTXd5Sm50WFRjUVJEd1hTNzJReWw1bk9JRThDb3RMRWNiaG9qQVozcEdB?=
 =?utf-8?B?ZEplSWZQM0pMdjI3Rkp5UzFwTkYyK1UwQ21TaXAvRGZBVUhMOGZCZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6b0e37-2df8-41a9-cee9-08deef4ef5ad
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:59:14.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpjASZZhkSOSxNhmBU9O/PessNHjrzHaJ+m690gSuMx97cetyPBDwYMbsKcQZRGs7+UD7NnC02GYr25ge6IzzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2954

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
 tools/perf/builtin-trace.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ba0f8749fc7d..b0ce9c2a24e5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2098,6 +2098,37 @@ static bool is_internal_field(struct tep_format_field *field)
 	return !strcmp(field->type, "__data_loc char[]");
 }
 
+static bool field_has_hex_fmt(struct tep_format_field *field, int len)
+{
+	const char *fmt, *pos, *end;
+
+	if (!field || !field->event || !field->event->print_fmt.format)
+		return false;
+
+	fmt = field->event->print_fmt.format;
+
+	/* Limit scanning strictly to the quoted printf format string */
+	if (*fmt == '"') {
+		fmt++;
+		end = strchr(fmt, '"');
+	} else {
+		end = strchr(fmt, ',');
+	}
+
+	for (pos = strstr(fmt, field->name); pos && (!end || pos < end); pos = strstr(pos + 1, field->name)) {
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
@@ -2125,7 +2156,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
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

