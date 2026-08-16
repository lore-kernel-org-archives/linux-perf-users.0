Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020086.outbound.protection.outlook.com [52.101.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420C3D16F8;
	Sun, 16 Aug 2026 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913973; cv=fail; b=hxItzYSRU068PZI5KUBMCAjkKlFTj+6XFPGrmX6y1uuw8UOVYhAS4zyUVtXPonCzW3C7/Xu7Rc0zXXui0gvExjaIg/2sb9vp0IgAJ43GyHG8YOXZhD3eMv38Tp5TRJnTyI5xkY1nhUcQEhhBaxkFC3/+p6ctkDLLw3GNceRZZbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913973; c=relaxed/simple;
	bh=/dT15EN5BtXqC/Kc+JIYw1DdFsMy6ur+RmiE+0tyCcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1YCho8b9JHKFJzAVCJN32EleS87DjFXjUTcqzpG29s+N0x98HM6JytextJ9+CEM6O7iMQOcf5sPg2elywts+bp3mL1s6LBMDHQ5ViMIN4ycxxWLmVRXT4drCP9wksPUGUeNdYSYdTuZF/bcArfmxAbwfNwvNyGQdoCFVXm58Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgbYfNvhKYhVwuwO8CT6bihl7qhniDLgZxAAgrP+ae0b8T3cHaxPoi6MRBOcanfhJMDNz9IkZ8smR2S/oUcmoZOptoiAhn9iF1pe0OFZ5OlQUh/6C1f3QqSXn+GXpry56Dya8tzohEIOB1yMQ0qgSaiV0fyLG8pShMCXjpN7eX453naH0LB2RjYkyxyYLsc1PFL0HyLxfc0r0itDE2yPTwr5uzwZyC2IuyUJNAHREMBpRwqrH7nJswcELtqUeOSKLi7HdhwIaCLtOI9K38cIlKMWsO+noKlzuYEO9RHF8jpSHi+ysDj77dcBrob/bSgtUZyRnhOkFrpuo4NZXFzCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+LY40U8azJZOZVX5dkyDjbVu9cZgdNS5hWk4U+zDsEQ=;
 b=Q3Qxt+CUPnmeGNxucSeJf02ER2dBWLnxTl/WcwYMnJgOUoXei+/OYdyURxdpPSNP4KR4SEcyU1hCPPK7YWwHHKVgYJGqkU/8NHsav2Quxd1FbB7aiEuk9Vqk8HeW3LnuHdSZZCq9MCNKBtL1RR2VSPX55g55jzj1t2b2hx6VKUZsx05L0KWT8SRvBNtO9bnxZ9K+lIiFLIDuE4z1Zs8Ct27iqTo++xaOYabj3zTtVkvwL8gS1FgQOPJpeFQ/tSVEQREpaYsYy7CBjwK/0Cbd4lU3+c62P5ALZjzJA1st18A6xF+YHTGQ4i6pjQidWLkYNUAI7Tq74Y1Tgz38OWaTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2682.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 20:59:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 20:59:29 +0000
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
Subject: [PATCH perf-tools-next v2 1/4] perf trace: Introduce kernel symbol beautifier for virtual addresses
Date: Sun, 16 Aug 2026 16:59:18 -0400
Message-ID: <20260816205921.576365-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816205921.576365-1-atomlin@atomlin.com>
References: <20260816205921.576365-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:408:f5::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2682:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b996971-6f11-41ef-ee4b-08defbd9435b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3mq/bn9hS1VUTK6dxPEwE0Du+Ypuf9mBU7l1Mcz6Gva/A82O9gAK0IJ/7mz1nreGojt6ViS32sZjIiHYmZ0Igb+oh46jRjxVOmoLa7Z+8ffADPiHy45HLooJr8vgIrJjnSE/gVz30V8nUsUG6s2h4IvlkbYeUTMjvfEE6LRFMtYjaFgHH/cOYmQwxJ5j1WnYHe3FU/1unBxFgCgabmOlZz/3zbJbqho4h6F/ax7K7FAgZwseZFJeDCcySWspydR4xCVszXYp+I31mkYGpzm1V0dK0rCt1zyMWChjr6EM1HTq34zVkPj+65wj7YQjDzlcZcI84EZkiS/oeL/pF2h0sFePJ0glb9Ivtm/7ERA+/mlmnChiuSryqw+V7loRWJWbASppxENwYeQz93BzCrKAgIr1eX7uQOQGVlIHBWGjMS1ZMaZOf3xkNt0caYuu3y2+/H1vC2wSpVooZ+QRXtjLNWZ0vlP4LMl3fD1vlLEXJjH4Sq9XyzI77s28XU7txtQ6DkMMI/i/0RGTnin+P1A3HTz1qWlvQlsOdL+RTejPob+RHoUFK9JEpAssY51HqIlnxb/P3t1gFzsFoS21mxcE2f7tJY87qGzGFCsAPTGYIHH7Hi/2NxAxSa5XvLk5eAhYxujPxmQpJ06es2+BxIQSyyrzWhI9JMnGB0saqqLOWnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJdKrK+y+sFGcX8y6gFiSzkn+at0FiBG+LFV1Cwcm+dfUj6nySVCJvTCDvot?=
 =?us-ascii?Q?GUKgQCEXU2XflniTqJ/sihKO3wz0gbJSCWKt7Ex5/LRMsVHo9iSDncyzMmMT?=
 =?us-ascii?Q?L9Pb85FDgFbywAGdVFyuxAjOroV68h5xs36+Gnz4l3zUynUxL7MzhQIKFM6/?=
 =?us-ascii?Q?VRM08pDsQwN9IuDcpKuaiBTyFTey26GaYXlzWHT9rY7/AVR05Cp5PGmwL5VE?=
 =?us-ascii?Q?sZe6Owd1cvYwdZ6X14kHJ9BdIFu7ekczbGHjGi5TlWXq3UlwozziJYM72HjM?=
 =?us-ascii?Q?/dTbaMTeoQGUBbSnymlcLbfjBzpgG91StSSkHJ2Da0YJbmEhUOk66eW7IPjf?=
 =?us-ascii?Q?qsN5RUr2LCnIzG5w7VsCtIpeokcAkwvd7A59xAGmu4Nr1ykYZMekB+52KffE?=
 =?us-ascii?Q?VN7hILiSjWZnq4DegrESkcRZ1hF/yYUaFGP9eg98Rv2EZ/0tNGZBV5W3joaJ?=
 =?us-ascii?Q?Wpsv8zx8Fqpyuwy6MQHTq4nVCI9r2h4jiipV3bQhDeK1QlgkaPDRnwX9YvZ0?=
 =?us-ascii?Q?8wwdqQwu3VtQW1UVSKbW8dZJqWMTB+Qkh8j09pHOw+Pv/aeHSdfH2bnR1ul2?=
 =?us-ascii?Q?uwKdi4GMAAOKV6Y+3zy83wvpJi/QHGekAq2VdLFOQ5GoOTxM+llfK0irnarT?=
 =?us-ascii?Q?pQcDC6G83/0IhGur/HtrLKpa+ug64IJby7wWzhcSJV9P7d10GdkXfndclryS?=
 =?us-ascii?Q?Y/nE6XFipuumi+1R8tTJO0jK5Qrxv8fGHsG2uwg2ZHrOcVgstPnJZTIWiR4A?=
 =?us-ascii?Q?+V+56E6Dy9l1cfFMOFtjaDuzi+Az1jC1Ry20CxGWkESUFa1afk91YDRh3D4P?=
 =?us-ascii?Q?xf0xeDhBrbmnBc6OKhBlrXLWAEbQlIXx9mgKWv2AutGrFNMmkP+YhawztmD4?=
 =?us-ascii?Q?omcEf4r5FVzOEnHPdy0bTDORiTtssqmbQYg5bCdgZWEbVNJqBRzuNKttUb11?=
 =?us-ascii?Q?D0Qxp5UTWEvIR2R6k79zjHUNaUs8fJ6632TX4sa0Dng2j9iLKQ4lLxU++kid?=
 =?us-ascii?Q?yk9BKKF7/fotYQXO9ve3Px2VIN7/oX2VGwgToOgPAHgVpeK+VkUgx+yd+tqX?=
 =?us-ascii?Q?hFR6e4cMIycnQC5TYUYoXWHZDWWav2BBvWcqM+J5NZoB5N5aj3T9iE9aBTId?=
 =?us-ascii?Q?3NzN0xkseVPupsYoGIDJu0EDfhzi2gNSq+mR7lGvkszBA138/TGoMvW2y4k9?=
 =?us-ascii?Q?/5FPUX7SNs9IWuX2030xiPDx65Za4nz7E6tWIiUbyI/RQ8wZb94/MfqzL4vG?=
 =?us-ascii?Q?mVjovypox+ew96ILpiKwTeW8DURO3vLp8dYuuAEhn8SxihHVoimpNmQmlyby?=
 =?us-ascii?Q?v5tm9wKi4JKUCamiyYIMWlbH2jortnr7wTPTBxtenFzHwayTlGpmEjKBYD4r?=
 =?us-ascii?Q?183EC8fraR65vC5lR3xqd5vbbVseTdP83rqBdUNz1jRn1q27LBaFTFPF+4jv?=
 =?us-ascii?Q?g/0cPfVWkHHYIL7jPAlk5zw1g1i+3WcP+2q8BSRk+Vr/7EnMvDZ9LC031zLs?=
 =?us-ascii?Q?7Sc1ImnyrrSJdwfNXvm/afGNdMrHagAEgzcKqLJp0FEF77C4aOBSAlMC3f1C?=
 =?us-ascii?Q?HGsHiECJDw2zfyUYzaEp0iIYfUPsVmCYyAvcqsF9xw1xmJZUOh7UYkyRrj+h?=
 =?us-ascii?Q?uoLToP0XY6uE75iEnhGR95udWmEq4VY3ziji7W72AkiFo6/tS7p/z0afXDpA?=
 =?us-ascii?Q?HlY3hqK9rJKgrCWfSG3lg4MP7qTxtFlBx0VK2z2nyKCoXGtHVcbX1ye+bU81?=
 =?us-ascii?Q?euZWCFWeqA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b996971-6f11-41ef-ee4b-08defbd9435b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 20:59:29.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MddJF7uNFi0IQm4zjqEewJm1Aeu+job+AYPffPUw5tmA3xapLcBaf9Kt86j0fCQkw014TO6DK4uSd5E2xE7Msw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2682

Currently, when 'perf trace' formats tracepoint payloads or system call
arguments containing raw kernel virtual addresses (e.g., a work item
function pointer work_func_t in workqueue:workqueue_execute_start),
it prints them as raw hexadecimal values (e.g., 0xffffffff81234567).
This impairs readability when tracing kernel execution flows.

Introduce a dedicated kernel symbol beautifier,
syscall_arg__scnprintf_ksym (i.e., SCA_KSYM), to resolve kernel
virtual addresses to human-readable symbol names and offsets
(e.g., "flush_to_ldisc").

The beautifier looks up the virtual address in the machine kernel maps via
machine__find_kernel_symbol(). If a valid kernel symbol is found, the
symbol name and offset are printed without requiring --libtraceevent; if
the address is zero, "NULL" is rendered; otherwise, it gracefully falls
back to hexadecimal formatting.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c       | 29 +++++++++++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..003048946503 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -750,6 +750,35 @@ size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg
 	return syscall_arg__scnprintf_hex(bf, size, arg);
 }
 
+size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *arg)
+{
+	if (arg->val == 0)
+		return scnprintf(bf, size, "NULL");
+
+	if (arg->trace && arg->trace->host) {
+		struct map *map = NULL;
+		struct symbol *sym = machine__find_kernel_symbol(arg->trace->host,
+								 arg->val, &map);
+
+		if (sym) {
+			u64 start = map__unmap_ip(map, sym->start);
+			u64 offset = arg->val - start;
+			size_t printed;
+
+			if (offset == 0)
+				printed = scnprintf(bf, size, "%s", sym->name);
+			else
+				printed = scnprintf(bf, size, "%s+0x%" PRIx64,
+						    sym->name, offset);
+			map__put(map);
+			return printed;
+		}
+		map__put(map);
+	}
+
+	return syscall_arg__scnprintf_hex(bf, size, arg);
+}
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return scnprintf(bf, size, "%d", arg->val);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 58a3206481ae..0f4801c61a5b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -160,6 +160,9 @@ size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg
 size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PTR syscall_arg__scnprintf_ptr
 
+size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_KSYM syscall_arg__scnprintf_ksym
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_INT syscall_arg__scnprintf_int
 
-- 
2.55.0

