Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951905;
	b=dBvw09hLr9Y9q3selm3Mv4O/IhpTtuIK0ZnH00FKn6/3vmv3qLVb02MHN+FXMl498x1v
	 VUack+Of0iCh1G0FcJGGJvne2gJEua2+ldg9XUPWxUlgzXzeWNuw4oBbve1jXWwanYkZo
	 Bq08PKpGLO57aZveL25FJ72c/TpEcJIf6Q1rj7IuZ8luDtsfNWckvZq9++UGctKbVMb58
	 fXcBuUYVzf+O65JeMFKbBLKLGMXI5RU3p7jhr1z0o9XkR+nrZTEULpxBP6qdLjYDe/qwv
	 Dgje+Bk56nhVF5kH//XOEG0o5GrRGYuLRMiL5DUAm9d7g0zNJtYAJq+9+lKWD/F+3DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951905;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eZp4rrmdY0s4A8o1LRNbbqn1bJ5GrqK6NKfXRyZbmu4=;
	b=RNlPzqNzB2g5WG68F+kmxNujPus2mjcmVTUwgWGImXQeFXNyk4iFLN2dA7q/JPqdrYJk
	 /t2gYXTidU0jRkLJXCjP5wowXnsvEhQd5cQsjrhOAKtwyuldd8oUEEctkA0jsxJ1awueY
	 VtDOOyipZG9vKgfm61vttEBR+wvPzXcW2TZfsY2DW+ghLwg0S+MaReOjOW8J8vPCIINOn
	 BgkNVmwmPhY5X3KZraJdLeI2WqVZZeSnij9mnj7BGNYSGUU4ieKSthxhZxbqahhEmxNGA
	 +iThgqL53NXOpdyB0vPAyHn45dQIywuKXnVtOWWh/Mzna3PVVdhYLRLmBos0z+2DjxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.117
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020117.outbound.protection.outlook.com [52.101.196.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE3606A32E;
	Sun, 25 Oct 2026 18:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAEE3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+m/mWxdsgQVPKP0E5JIbCvbzHW7YrOpp6bOvIVVyCr0Np8BrGZvTekFhMv2d35VpSxVyaGJ211wOV3VjrUek7auQ06/zEwYa9VQiH0XtrXMWbXKmvzM00E0QeqDbuOJ493xMku8jqqHMOWXFdUEIPp1t0TcmWXpVR2uR3F2MW0bLyRw6gJKhxjmrgiMElu7u5RBlWfeSNfOuBuC9dvYz6xkQNz+5CeqS7/qVMP11zuQU1nK0JiMGM4Nr2iMuDOVeDz2CN0jwUqePpUthxJVf2lLWg3eGMlMguQAy8fTb2Oa/vUjizayWc6F84BeJhWLj15u2x2lmIdAUVGNmdIHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=eZp4rrmdY0s4A8o1LRNbbqn1bJ5GrqK6NKfXRyZbmu4=;
 b=n8z1wtP+KPJEuYNgLX/nZzkvkMXXQZMmoZln6qevXtG5thG7QFGYwmb3efbhvcZR9cENZpZgGbYNMytp1L+ZrCJN4cz5YX/pS1ev9/V91i9Q9/IZRaN1gfFOh1bDtjHXYYKVnG5tQKid5eOPodxNN/rZRiDYETTrF7FlEaqwZ+jnpGFC31U4L0bykt5NE1I03SKGnO3CoIRVeBTkL5KyBUa1wiIBthxJrG5COLx29gs+lURH2tozKGA2NA5WuDQ+XNVucQAWnpvxYMGj4KKYyNw4pLh3DXHF7vucAmT77XHlEY+4ySRuLPlkaUTcAOiolQmod/wtLxIt8xknbCjH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:11:42 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:11:42 +0000
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
	atomlin@atomlin.com,
	chjohnst@mail.com,
	neelx@suse.com,
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v11 03/10] perf ftrace: Support filtering return address comments
Date: Sun, 25 Oct 2026 14:11:18 -0400
Message-ID: <20261025181125.514372-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025181125.514372-1-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: d44d6f30-10ca-471d-9c48-08df32c36c42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|261022105027099003|261021135927099003|261021133027099003|261022115727099003|261022113327099003|261022075727099003|261009223027099003|261021130227099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3pCXZ5DyKodV9t9tEc4uZLiIh0oOYorpIzfo5AtN4OBgqbV0PSVOdrrYqBP+v8ngNdGo9y2NQGjj6sd+vQuOxAwi09tYxOAbjBauOCCggZ4kvpnViVuS4RAOxx5s7d1ymbt9Uzi8TXyvS71XwLeHNkv557gc/wMil0uU9Hbr+urAswJ7jJ9kIGJQ7JDyRk+gffjAGro3SAMKtFFAAY1VrZ/ngTL7yHIgG2lCRqIkG/7PcU7VPfIXJRqrPF2MtNLIXcOJGR+Uunc/BpcEdvOfhPhuR3ZR6a9nDr223DiozSkzsZntt6A6z22uTNuumG+MhajEHugIp+QZ0frKSUg+pn3auB9pe0nEj0yQ2brI4/d0wMrb+mMpgApHzecWTkwRNiaEbq3wfxQ++7KDxkQ/CwCi9xRE9jweQahi2k4YhQnOaWLLD0cQdymCn2WviUpllxt/sv/NJEM0Oa30Xy0z7Z/a7Tpt1zMMZ3dIq9sOvYxUZ4Fj5T8jXCLCDOHxmZqM4abrWEShT7qLj70aaLTUcQ7drELQC7qhHtVL5AGEolo5Dqey001uU7OIt8zlTIFPvzj7jo2eXrqPTwaKEyU4PJLAsZRdzw45bIqLmMI1eljSXvhRlGnSdJaLDwqauTOSgMBSvDQaSxMzYFKll895dC/sG87Et+1MLCDALTgwUjY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(261022105027099003)(261021135927099003)(261021133027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261009223027099003)(261021130227099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNvwkcKap47q0rB1D0twUzoqHZ/NpusFQuvInuEhdr6CDAA9FJG7BL2DrvJW?=
 =?us-ascii?Q?atkHNvrxIAYzdMJZASEOhwQC9jnkmCY5CbBB4g94jmVPztJiVwMsIPt1a9LG?=
 =?us-ascii?Q?h2zw3V7Cm6GdHupmZljLoo8k1ahaRawKtFfUDf84HjxVIau/SzZ46Cngzo1n?=
 =?us-ascii?Q?wPKdWcURrLcEftcFSfmmIhesxq7DNfT9O6b1bQjf678xmhEE6PI9JWFI/wAX?=
 =?us-ascii?Q?PTUAMS7n6MXB2x1gxBTWwY+JFxbPEggmFOWwEASsI76cMdOj5+jCvlTmaRHt?=
 =?us-ascii?Q?ygmY1K2B7soeGtpSKA1IjtasL5JrvKc5E3IrGxDz9nCyL+TglzrGabUw52vc?=
 =?us-ascii?Q?IoakGdd4b51ohMN6c65I12Io/+ldtROFjOdQLgGvmiWRDXHABzarK3jzi+fd?=
 =?us-ascii?Q?qqBZT03L01gm+ml5Z/pRVQ+f8EzGWyUrupVxv39Wj77Q8LE308ZGE4JekS51?=
 =?us-ascii?Q?lWELDzqP+FVEoufloa7/HV3c7LiWXhmJzC2J3Hj1fgGb4SpxckD3/oRofNYT?=
 =?us-ascii?Q?HtROHbBvK1/U7aySTQB9XJyROi++euY2/6nJayui+MZm2/UY74Cj23GrZ4kZ?=
 =?us-ascii?Q?7cnTv+JsRP6R589YRMtGYM6FytdilWs4x3fS3Jhri1ENc3xy4D+YKq5/QwD6?=
 =?us-ascii?Q?vVzJff7F4n1Pf+HvsocSIWvdWAEBpYHIDH0IVS/zXkkfRG7RUy3DSOWQdO7O?=
 =?us-ascii?Q?tlyA82wg67ojx8Kle+9kkuTt6iAY6mIi1j2+7ytsYKimbgcamFgMHvpOgfsl?=
 =?us-ascii?Q?do+HiYvrJkI5U7WrofoNdF21cdbT6Hkz0mvfgPWUUgCoTZ9f2qrcn98BZtgP?=
 =?us-ascii?Q?x89KBLzbxzNh2M4szJi1mCdNroCUw+Jx37N5LGX3a7wW4ZL6/n4Iq9yj+znZ?=
 =?us-ascii?Q?sf8gegHwBh7vlw9zl/ofFWEg3Ns1C8ZXFr4Z7XvxmnpY0i9YO/nTw7slzDaS?=
 =?us-ascii?Q?vy4nzX1obPYYtb+47/pXVPqc4EffMmXPMXsO+CCCU17roTpoF0ys78EWLd4s?=
 =?us-ascii?Q?FXx7SczV+ZjunCZdqPCdV8S4qSGDl+DbzASSSLmC6WnCNOgrcjEy7oXRs/rG?=
 =?us-ascii?Q?5cQVSw4awWuBehtRtcSMBogv/rpeIcZdZQypszbP3ejY7/xXMVGdx9uvnPub?=
 =?us-ascii?Q?ggt9R+LAE2NKCM0t6dSOEm/LfRanTzwKNmSKC1CN5DhipBb+6TtLMB2DrGZs?=
 =?us-ascii?Q?TRZkBkWF1Ji3eqBk7nFpm2UI92CdYzeZmizrmRTjmDu43+0p+I4RCgxSL/77?=
 =?us-ascii?Q?aJr1COaunkHuvnIGFJ0jYkyU2XaAkItestu9ZXwT1bTPavYAoFTLDm/MY3NC?=
 =?us-ascii?Q?vAFhloU5863Jn2j/KRT1hrlhqR8sDL3QRsXDigz6byBs3bJxfPaogTpi7XnQ?=
 =?us-ascii?Q?UkNj5lwNaq50FSBHa7L+i9bJYG3iZQG3npD/zpgBrEi+G+n+f1vEKyofSA95?=
 =?us-ascii?Q?RH2r5Ebvn1Oln2CeBKfYKNkp+FdjfsHGd4f3csaJBkz5D4yBGnqzvmfgNPhe?=
 =?us-ascii?Q?HXjHAYFzaBFHA/6PryvtHzWgKufgbFyySM2K+NsGRnZ4AY+A6wq3MzHvxyfO?=
 =?us-ascii?Q?t9ibvEWaZVMyIYqvKPZXoZJqyYTiGdRfIyjM3ZdOM+h9DybDYURMauLSIdoU?=
 =?us-ascii?Q?mDdUYCLYSYQkHtdVbvqhOPA8h7os0zb44uDie/4d8ulICuvOLn5Jks92QTQ3?=
 =?us-ascii?Q?QZKOL4YDa/NnH7P3+cK0sfm0PNrWVjje+30HzT9pah5/YrfbIARlqmkJrVJL?=
 =?us-ascii?Q?28wH67aVAw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44d6f30-10ca-471d-9c48-08df32c36c42
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:11:42.7897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz/Ib3mQZDW/ShsH/WS++ONYRoMRVXn0sDr2Ab4DvLF4l9cXX+uUIs0YnvSQ3sWXb8GF7AGvin+diXvX/GeljQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

When tracing with the Linux kernel's function graph tracer, enabling
funcgraph-retaddr records the return address of each function entry as
a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
Whilst valuable for tracing execution origins, these trailing comments
can add considerable visual clutter to the call graph, particularly
when examining deeply nested call trees or when synthesising higher-level
abstractions.

Introduce support for filtering out return address comments from
function graph trace output whenever return address display is not
explicitly requested via --graph-opts retaddr.

Key aspects of this implementation:

    1.  Return address parsing and filtering

        Implement ftrace_filter_retaddr() in tools/perf/util/ftrace.c
        to locate return address comments and strip them in-place with
        memmove(3).

        Additionally, introduce ftrace_parse_retaddr() to parse caller
        symbol names and offsets across diverse output styles (standard
        format, return values, and bracketed addresses), establishing
        the parsing foundation for subsequent inlined callchain
        resolution.

    2.  Automatic comment filtering

        In __cmd_ftrace(), filter return address comments from whole
        trace lines whenever !ftrace->graph_retaddr, ensuring clean
        output unless the user explicitly requests return address
        comments via --graph-opts retaddr.

    3.  Automated verification

        Add a dedicated unit test suite ("Ftrace return address
        processing") in tools/perf/tests/ftrace.c to validate comment
        parsing and string filtering across all supported formats.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c     |  6 +++
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  1 +
 tools/perf/tests/ftrace.c       | 81 ++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |  1 +
 tools/perf/util/Build           |  1 +
 tools/perf/util/ftrace.c        | 93 +++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.h        |  3 ++
 8 files changed, 187 insertions(+)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 65983259b07e..e00621703dd7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -837,6 +837,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
+					if (!ftrace->graph_retaddr)
+						ftrace_filter_retaddr(linebuf.buf);
 					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 						break;
 					strbuf_setlen(&linebuf, 0);
@@ -874,6 +876,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
+				if (!ftrace->graph_retaddr)
+					ftrace_filter_retaddr(linebuf.buf);
 				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 					break;
 				strbuf_setlen(&linebuf, 0);
@@ -885,6 +889,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (!ferror(stdout) && linebuf.len > 0) {
+		if (!ftrace->graph_retaddr)
+			ftrace_filter_retaddr(linebuf.buf);
 		fprintf(stdout, "%s\n", linebuf.buf);
 		strbuf_setlen(&linebuf, 0);
 	}
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 395f2866094a..136138932fcb 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -72,6 +72,7 @@ perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
+perf-test-y += ftrace.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 880eece0bc12..640d6d327215 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -156,6 +156,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_hooks,
 	&suite__unit_number__scnprint,
 	&suite__mem2node,
+	&suite__ftrace,
 	&suite__time_utils,
 	&suite__jit_write_elf,
 	&suite__pfm,
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
new file mode 100644
index 000000000000..42604811a2fb
--- /dev/null
+++ b/tools/perf/tests/ftrace.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "tests.h"
+#include "debug.h"
+#include "util/ftrace.h"
+
+static int test_parse_retaddr(void)
+{
+	char sym[128];
+	u64 offset = 0;
+
+	/* Standard format */
+	TEST_ASSERT_VAL("parse standard retaddr",
+			ftrace_parse_retaddr("kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */",
+					     sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "load_elf_phdrs"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x6c);
+
+	/* With return value */
+	TEST_ASSERT_VAL("parse retaddr with ret",
+			ftrace_parse_retaddr(
+				"__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */",
+				sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "load_elf_phdrs"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x6c);
+
+	/* Bracketed address */
+	TEST_ASSERT_VAL("parse bracketed retaddr",
+			ftrace_parse_retaddr("foo() { /* <-[0xffffffff818534c8] bar+0x20/0x40 */",
+					     sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "bar"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x20);
+
+	/* No return address */
+	TEST_ASSERT_VAL("no retaddr",
+			!ftrace_parse_retaddr("do_filp_open();", sym, sizeof(sym), &offset));
+
+	return TEST_OK;
+}
+
+static int test_filter_retaddr(void)
+{
+	char line1[] = "kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */";
+	char line2[] = "__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */";
+	char line3[] = "do_filp_open();";
+
+	ftrace_filter_retaddr(line1);
+	TEST_ASSERT_EQUAL("filter standard retaddr", strcmp(line1, "kernel_read() {"), 0);
+
+	ftrace_filter_retaddr(line2);
+	TEST_ASSERT_EQUAL("filter retaddr with ret",
+			  strcmp(line2, "__cond_resched(); /* ret=0x0 */"), 0);
+
+	ftrace_filter_retaddr(line3);
+	TEST_ASSERT_EQUAL("filter line without retaddr unchanged",
+			  strcmp(line3, "do_filp_open();"), 0);
+
+	return TEST_OK;
+}
+
+static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = test_parse_retaddr();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_filter_retaddr();
+	if (ret != TEST_OK)
+		return ret;
+
+	return TEST_OK;
+}
+
+DEFINE_SUITE("Ftrace return address processing", ftrace);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5982c4e62cd3..cd12ae85ccfa 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -180,6 +180,7 @@ DECLARE_SUITE(perf_hooks);
 DECLARE_SUITE(unit_number__scnprint);
 DECLARE_SUITE(mem2node);
 DECLARE_SUITE(maps);
+DECLARE_SUITE(ftrace);
 DECLARE_SUITE(time_utils);
 DECLARE_SUITE(jit_write_elf);
 DECLARE_SUITE(api_io);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1f880c4c47..5b082d09006d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -169,6 +169,7 @@ perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
 perf-util-y += intel-tpebs.o
+perf-util-y += ftrace.o
 
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
new file mode 100644
index 000000000000..452231c01568
--- /dev/null
+++ b/tools/perf/util/ftrace.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include "util/ftrace.h"
+
+/**
+ * ftrace_parse_retaddr - Parse return address comment from trace line
+ * @str: The trace line containing the comment
+ * @sym_name: Buffer to store the parsed symbol name
+ * @sym_len: Length of the @sym_name buffer
+ * @offset: Pointer to store the parsed offset
+ *
+ * Extract the function name and offset from a funcgraph-retaddr comment
+ * (e.g. "<-load_elf_phdrs+0x6c/0xb0").
+ *
+ * Return: true if successfully parsed, false otherwise.
+ */
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset)
+{
+	const char *p = strstr(str, "<-");
+	const char *plus;
+	const char *bracket;
+	size_t name_len;
+
+	if (!p)
+		return false;
+
+	p += 2;
+	while (*p == ' ')
+		p++;
+
+	if (*p == '[') {
+		bracket = strchr(p, ']');
+		if (bracket)
+			p = bracket + 1;
+		while (*p == ' ')
+			p++;
+	}
+
+	plus = strchr(p, '+');
+	if (!plus)
+		return false;
+
+	name_len = plus - p;
+	if (name_len == 0 || name_len >= sym_len)
+		return false;
+
+	memcpy(sym_name, p, name_len);
+	sym_name[name_len] = '\0';
+
+	*offset = strtoull(plus + 1, NULL, 16);
+	return true;
+}
+
+/**
+ * ftrace_filter_retaddr - Remove return address comment from trace line
+ * @str: The trace line to modify
+ *
+ * Find and strip the funcgraph-retaddr comment from the trace line
+ * in-place, removing trailing spaces where applicable.
+ */
+void ftrace_filter_retaddr(char *str)
+{
+	char *start = strstr(str, "/* <-");
+	char *end;
+	char *ret_ptr;
+
+	if (!start)
+		return;
+
+	end = strstr(start, "*/");
+	if (!end)
+		return;
+
+	ret_ptr = strstr(start, " ret=");
+	if (ret_ptr && ret_ptr < end) {
+		memmove(start + 3, ret_ptr + 1, strlen(ret_ptr + 1) + 1);
+		return;
+	}
+
+	end += 2; /* skip end-of-comment delimiter */
+
+	/* Also backtrack any spaces before comment */
+	while (start > str && *(start - 1) == ' ')
+		start--;
+
+	memmove(start, end, strlen(end) + 1);
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 950f2efafad2..a3a679f74e9d 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -93,4 +93,7 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
+void ftrace_filter_retaddr(char *str);
+
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

