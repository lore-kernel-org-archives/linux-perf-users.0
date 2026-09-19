Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022113.outbound.protection.outlook.com [52.101.101.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B296379EF0;
	Sat, 19 Sep 2026 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779376; cv=fail; b=KJV/YXCJSbFZO5pETVPQvfg3HmFhihMsIgI0gsikRhTYOAhxRgi/EtttxKH+xgO4NvYyMPG5SIrjK72U4z+oCL3EQTEz3t0P1PR9yQQo4T2a8l2gCAoHIkE3XcoSq/Js1kiS6F1vRqEZEmXAcXSQkK1Mi7Yar/7dXVDSU3UEajc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779376; c=relaxed/simple;
	bh=8FzfVZiSK95kQ3iGwU5eIpymwJus/HUeRyPFSVyFI60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GcJc7GVEknOKTAbkc05l8Oy6SVWk+z/r5PoSWXo+JSYTO6LJn3vY/oM89ywDVi31VcAqXV+Jdd3DO5WTnWauLGl7WY5pJQnDuiZE8eRuiWqhn92x3Ic0bmMi4mMZwMOvpOwSe9FrsV6eu3rvFuZX6cy9SW5OXXA/uoS7xXnUBNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo67u3/HSDH0UppsQjVnPwLPoe2iqgiI7JenIx/S6boBdQb8r9i4HHmVtlNfa5VDbm6dIRh/ISKoBHwcJnTeex3w+MezoGLevx/+UDwJFgbE/HK+FVT021TzQo+rpe2hpFEaqGbhR6xSU9RpYc32zv8kBYuioJovfHL66/GHSg4RIMyse/yxFvA1jK55QOtfjRreKe/MkEzoY9HkbGPEZ4qMa1C/Nrzvmhj1iVsFJ29MJemZ3HLPokVf0zt74MpEcI4P8C2NFh1RN76G6gdFIzLGPoP4kGnBOlOmxBXYpzbZxkzRScoSWRdSSRZhBoJh8BEhRZVtdJ74+NxDhPOiMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vFmUu4WU+UjHQ12N5OLB7qxHkankLDp0G69UXGk6Go0=;
 b=dlXTmaaUhQifmYmz/IV2IpBqLBAKx7LJ0Qt/kvqCgw8O/oF0K87gnbFyzBeeXI5Yb1W57STww1glAG0TBqUFL+M3NEotRy85ZiI41XT2WIg3NHTg8RRPWUnnQvE//095UiIr14uXsDMceJcVMsIlpjSnT6BY3jAIi9Cmac2AiTVTDxLJlHaEJh2X5znXyYqYHZDa31gBK1HG7dCqQj4jqkzsKCPgpSO2l4yGNa+tDD7Jme7P3qjhLtm6ydWLpCvHgdwKUhELuuzcFFrnQH7drL7orY34RFQTllrjyDb+6pysxX4cWvU/B3d1PrG5IyK9zaAI6cC/YgfCwWb0urJZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2769.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 00:55:45 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:45 +0000
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
Subject: [PATCH v3 perf-tools-next 3/7] perf trace: Align pointer advance in augmented string beautifier
Date: Fri, 18 Sep 2026 20:55:26 -0400
Message-ID: <20260919005530.728615-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919005530.728615-1-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:408:fd::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb95fd9-eae2-462d-4e3b-08df15e8bc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vUo4sEBMzUUeqBp5K54MrWheTbYGrqjC6qX9+Rf1RAA6ItniXRrSKR6tv/LfP29ZR6j6zPFSalxYsmRybwxI40D5ssIV9YdKgJ6M9FZy2Kf4p/otpbYtlXmxJDb3NojZfRv7B244IRbDPiPeukz4M4Ni//LBXMmYzzc6w/JFAdq9Nwwkt8ObQ7CFPrrgMBTyxOHqLyOahQZiSBquWLs51NvE2DIA8U4KvHeROXNF3bUOumFcCAr7jB6vfe8HcSAJsJxvLD/cb3FtjgAh7jkl1D4MtCcL6XUE5UGNXQXoRO/BXt6XA2rCnHM5Hmhd2Oz5P3yaxte42UDD6ILQ2t04jER+4h2Aifo0Dw5iL0Cm4/O4JmCD0BzpTBosWRHTSa3Tb8Lj1i2DWZBnnGufYGF2uN9XsKxiObUxozhlqKT7FzIaj7E0MMmoa/yYcKkdvEQkS6zE+56APQIqtthbQH0ZiZ3niJ/eW23WdzR9txMi4Ic/9nSxJ2bFtTiBfr0YWy+siiFspoGrYWnSIT3xnCPk4fnKWua1XpcY50M8HHI5C9aN+0uY8cM6fFO3dwOxUEWl6E2XkF1fVCh8N8nuufKmVNks00vVJpyBsdHh96i2LI8evSg35OhhIJXgTZy6tbJ6ZfFUsZMeBQlkjIQQ6EyKsfdPYhSvvXE1xuY6Km9VQ+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GVNl/s+/vTqNuqAnkTs7xMwS4OLcAD9sLl/NlaEIbGJU3MwVzpYw1BsRXfhH?=
 =?us-ascii?Q?+N87VICf2POY7Wa+qZdL1Nr6J5OIid5nASH8wNS6pA6mUz0hjZgWDtWl+6lC?=
 =?us-ascii?Q?wpuVrqlkUeR1XoVPwCV4N6PGSJ3Ehcrsw9qgGNNyWtYLp0ouE0Sfo5GEQrc3?=
 =?us-ascii?Q?I87NJEnxDbBbHjZxSDE9bjMXrv1NrWaNxTD59eRilRwMSNiUDwyrKM5o5CbC?=
 =?us-ascii?Q?JTndueSoliyM59xLp+lY7eg24y4/X6qOikwTEFglcagro/fQmQYfxMmEorRh?=
 =?us-ascii?Q?AqnTIJZEJgNxu8xu5SviFkKTsfqyCSKVUO7lCVWL0X6wUHa6DlJMNfYM70gV?=
 =?us-ascii?Q?nJ6yZxg8Rid4acQb++ZwlONGPCnQzuNL/MKaFnnHHYv+TXkFfQp4hkZS1Ci6?=
 =?us-ascii?Q?MCa3Y2uqdQhvLWXEOMA72gn8NTuyF41zLcXqAtktKwQLnjJE+nSR7fALS02l?=
 =?us-ascii?Q?IGUdzMFU2/Aw6tYh1QPC1ZakO5XTzkIEQHQ59vxwZ6KsieeESa06rFM/KEvL?=
 =?us-ascii?Q?YAUeI29tBYa+EYzrk61bne0DNQ6QOa1WO+dX8Cw0HFTjy0QFtkazGwXcenlw?=
 =?us-ascii?Q?Geyd+LGzJHZQN4ZsdBqEjAo2LncX2fVIORXehS/n/nYrLxzlrDwy4K8SnkES?=
 =?us-ascii?Q?fru5pB54Yu/dsa5RX6n6NoiWlTVxi5NjsPGOxRGYVzFd6NW1gLb3jE/D7+mA?=
 =?us-ascii?Q?FvedSOZJ+pS4rFa/KJU35cdrP7N7rSsVMFU6PwLqNjB3Y6lo94iE1YQ3OEY+?=
 =?us-ascii?Q?Ez66g/qcLF24EHkpwwGn7PGpq6/VZ+qJaAuJn4JWzbHE9W8dxoVvruuTUbPR?=
 =?us-ascii?Q?1ZKqaEg4OawQkRSC/SaIu3pdfsur4y9difsYWPcdfC/sa2ij/VmFcnatbs2L?=
 =?us-ascii?Q?+Nikt68XTTC8hs889pnp8XDG4DSKM/dwfx9zvzgckCXqWxm2ocnI78Tso/wP?=
 =?us-ascii?Q?hxOIcY1H64v7qXzG3YieF/tDG3+O4eC1XBcEDwQaL20B9BJPhxeY0YahOz9/?=
 =?us-ascii?Q?FOmb7czmbzGfy/tpAs+Xf8EAFLaQZK1pcwGvV1zsu7ep7Dkdmd9OzAVHfR4u?=
 =?us-ascii?Q?WKwPxmzddtRIkqXINF8dmReHnsDfE/Xi7dU/I7wfbFwMy0vYbx3MWpvRt3fb?=
 =?us-ascii?Q?Ald/+4N7ubSzCn+Z2BXmI9h+IV4TDYVG10dFtcU7Ir753Lac7AvslkwDG4Io?=
 =?us-ascii?Q?ogyqM9fBUjCaRVnGYQvKKflXFeOeGRVjO8m1mHbd6TwzuobKC96gn1AssRNx?=
 =?us-ascii?Q?WopmcxuCoHk3Vn+Y/rGO/MxW4juayMDSZfGzk2izC3YDwArkU5bbB1jIvupG?=
 =?us-ascii?Q?ZKLeqWBJxZ6eVhPZSZ3E3/nnHeN5SWXdeT/naazEwN1LcEFBHZmgUJy1nNvQ?=
 =?us-ascii?Q?AcBNta8UxEycGZzIjjxCdVLzh7b+nq9kgdQY+hcmBovNEKRx0oAGeTlDR3sF?=
 =?us-ascii?Q?PW6lOVNJVFLMDFZGisP91cLTZOKPf4AEobarnJ0T45XEuYQs7FdB+gVj8v2W?=
 =?us-ascii?Q?lLX8WfUmJc+j7hvz0CHsCx9EdnHAdaGm4rRYhRVTJI5PRxDHS8NNNvuekXLA?=
 =?us-ascii?Q?sP8maKG2HYLlpevIsubJgPQA+SqfNfLPG76Cxo8d3vGX9iXHrgXf6sKDUn3R?=
 =?us-ascii?Q?K5Jm4uPkwrHXlqSSjVvsfXEfpVew+oFs+0lEdsCMgzLG+Mul4xIwRyQHo4ie?=
 =?us-ascii?Q?CR4Q7EDXT6BXr4fuwx5ERH4zqBrYq2sXIEnZnaQrKU3MYkIVGbW2IEV3Hcdo?=
 =?us-ascii?Q?8SCd7Mnqdw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb95fd9-eae2-462d-4e3b-08df15e8bc6e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:44.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeVTrQ+CgXVrK4TDLgms2N808cw7qo5M9E0bpBh+HEww+BMofubt7tfNq/l1VJ2RIGF9dyUntHJZLeVEFGfggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2769

When pretty-printing augmented string arguments via
syscall_arg__scnprintf_augmented_string(), the offset to advance to the
next augmented argument is computed as:

    consumed = sizeof(*augmented_arg) + augmented_arg->size;

Because sizeof(*augmented_arg) is 8 bytes, if augmented_arg->size is not
a multiple of 8 (e.g. from an unpadded capture or a malformed perf.data
file), arg->augmented.args is advanced to an unaligned memory address.

Round up the consumed payload bytes to a 64-bit boundary using
PERF_ALIGN(), matching the alignment produced by the BPF tracepoint
programs sys_enter_rename() and sys_enter_renameat2() (attached to
tp/syscalls/sys_enter_rename and tp/syscalls/sys_enter_renameat2).
If the aligned consumed offset exceeds the remaining buffer, reset
arg->augmented to prevent reading out of bounds on subsequent arguments.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 91461ab927b6..21c16e4c163a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1912,10 +1912,15 @@ static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, c
 	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
 	 * we would have two strings, each prefixed by its size.
 	 */
-	consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	consumed = sizeof(*augmented_arg) + PERF_ALIGN(augmented_arg->size, sizeof(u64));
 
-	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
-	arg->augmented.size -= consumed;
+	if (consumed > arg->augmented.size) {
+		arg->augmented.args = NULL;
+		arg->augmented.size = 0;
+	} else {
+		arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+		arg->augmented.size -= consumed;
+	}
 
 	return printed;
 }
-- 
2.55.0

