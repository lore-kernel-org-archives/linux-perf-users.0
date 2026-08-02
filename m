Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022136.outbound.protection.outlook.com [52.101.126.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D63644DE;
	Sun,  2 Aug 2026 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785677149; cv=fail; b=RW/KZfU+HKxL2fJQI0rElhubdXaHe8nb3JdIOSbTMaFJ+nWTvRD4Zl/A8jn2uHkKieuLe5Cuugw10L+IFFNvLCMCHJWfEW/rLk7CkY4ucQHlt5DjMJkjlvbJwT814rHCiOeqeYuNYpn72NSq0lrU9DxDg5U8B0cjhbV2JNYa0JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785677149; c=relaxed/simple;
	bh=GIzZtOYJNVJwiREm57U/l3fcQohO5MmG4kMB6W7wFd8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m5kA3nfNKC3mhnoZuE5Kp3CAooMeFBthiNc60stQVtlFvNBSC3YvXNbkcuISlfG7+3EeCwbK/K57ie5+V//Tq5AOHayXFkcX0jSdJXYNUzbxaAoTKqtgB9PLigtcanDemtAeDj/iecTqbkixnqA3czoC+64xckT8dGjnn8L/qlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=I71r8HVk; arc=fail smtp.client-ip=52.101.126.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="I71r8HVk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sILv7AMyEgwuQR4H+S53gBEi+s71d08CcA60faIWoZnt4e+CY8uf4JKM5nfSPNNt+ACqDvKzo0/g5CRmKPo9uygTiOUbq2+0fYy9DoRXMrwt9pmchFB5kMIMj+rL4mjiGebJ7pI+SQxuq86PtM7AnDDH/yzKIvWtAYQ6o53z9JwXw47Yk9TYqND8OY1dorkF/jucnDbwVRqKnT7mkiXLHdeoxSyK0getra3fY+Y0PmEcttoxWXiTwEFW37m0G+qW0P6++PGIYXyOcCQSlmMU/i+9Ep8T7P5CgCls5QIAuewfQ4uTTT6fztAXdN7qUOeN7Nx2tgBBvNHb1A3oYcFV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxhEg4rtjdhELs5uIHiK9argPI6PDJmtUYNSR7SGzQg=;
 b=NZFaPqqAhJfB9FKPx8ffg9Sv8cdRSy5ggyOCcDC24xaBTcDUn1VUWwKRrc+Ku/5iYPGYoUASJkwDUKKyvr69T5Pz18Mv6e9pEn7wk1JLbsokWvB46G0RsYieRbn/JlX1ZwPr6dkHFlY10ejGDl6hFFpg4bgncPpyG8iwhCtOxtUkj7C15R4hkgF78Z5b8aohKp/oSZHlx2ym4ZQPsySKq1miGip++6it7i//lRdgtegy0VpgyvQvSasL+X9IEI/Qa9ekEbR+rVuMG54qo8VEE75ubl0lSbcbXHaDcbIv1ljuIvbhuNUYL/wYRIFatWVyF4uO3VQoGRoHX3FW9tm5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxhEg4rtjdhELs5uIHiK9argPI6PDJmtUYNSR7SGzQg=;
 b=I71r8HVkZOP7bToJMB6bpPE69cGKKAvOxMgzeLsyJYoqsoEC3XgeK4m3gLJkMGvmQ9UQonJW4bRPeS2hJHLYQ2lrCeM2AhbydG/Xg/gj1ct5tFwc5JrWuTchkXIoRRPKFah8NGtIi8HgSF5uU3AZu9SYdPM5NaxQFepdmiqj4zo=
Received: from SEZPR04MB5651.apcprd04.prod.outlook.com (2603:1096:101:48::7)
 by KU4PR04MB9320.apcprd04.prod.outlook.com (2603:1096:d10:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.13; Sun, 2 Aug
 2026 13:25:42 +0000
Received: from SEZPR04MB5651.apcprd04.prod.outlook.com
 ([fe80::b864:dca8:c2ed:e5cc]) by SEZPR04MB5651.apcprd04.prod.outlook.com
 ([fe80::b864:dca8:c2ed:e5cc%2]) with mapi id 15.21.0292.012; Sun, 2 Aug 2026
 13:25:42 +0000
From: Pu Hu <hupu@transsion.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "james.clark@linaro.org" <james.clark@linaro.org>,
	Pu Hu <hupu@transsion.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jiazi Li <jiazi.li@transsion.com>
Subject: [RFC] perf pmu-events: Fix typo in idle-cycles-frontend description
Thread-Topic: [RFC] perf pmu-events: Fix typo in idle-cycles-frontend
 description
Thread-Index: AQHdIoJqRUODVN/Z6kS8V68nAzHvPA==
Date: Sun, 2 Aug 2026 13:25:42 +0000
Message-ID: <20260802132536.4635-1-hupu@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR04MB5651:EE_|KU4PR04MB9320:EE_
x-ms-office365-filtering-correlation-id: ffb511a9-79fc-4297-7531-08def0998d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|11063799006|3023799007|38070700021|6133799003|10067099003|56012099006|921020;
x-microsoft-antispam-message-info:
 jkLHgIMcDPROFWG9g0lD2bGgXuqZL0l586IT8cylLWLgam+dK53H4JHynXqwzLb3naVxN3jETSZURfApTVWN3AAj+RgcmkNhOpmKEpZcdz4GH3Vd9idxfhU7fMfEwD2916hhssxFVAlGGxLfHiKrXMHCTPhiC7d+1jvn9NrTkmkwmvMJUYv2s5SyiWVDQBZbcoWbUhKar7kmzgcnUTrr9FnmGEzkO+GbAZ1JYQBAYwoGuC/Zsz+fJMfwzdMjA5OZx53WwH0sqTnE5VA03h0pC4ujCm3lJvmBgKc/RwY8MWtrGvkE8R92TdwDAW+kgpJS/4SVsH2adTj7GR+StQtN2UEa0Fr/BDF3N4v08RNzkgK0W9HIhbbyYN8+HV6DWVLu2WsZCs0enhUit2vPhoM5UvbcWrn/CJZL00hbm7A/Aoni8O3KAgMCbmk4Ln0f8NFWGgnCcrVaiukHuhbWEQJDnPChbLnYuKlYoLMJ+CDF6ktTfOyYy0K+CT0OFIoZdh+yR6QJe0ZM45ZjTQyxuvlscr+TYMWGFiYyUWgJCdEBFJ5KIwuXQWO0bWDJicZfA982i5720KLu1krNbcAgNLgmfm/RIku6H9yWgW/SsLHydAhw8CMPyCVA8zy6rnRbIUY/GeeS6XycO0qhZ7jiAU1xgsFzZZxNd9m9kfdVoVU6t/uQ3Mz9iFOYP9Xp0Qxvcy1szqnscuZKiS7UgLjIVaZs3ld52hkiTFC+uHnpWBJseJ3b6ilJwBAfhFLgruSHIqMw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR04MB5651.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(11063799006)(3023799007)(38070700021)(6133799003)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FbnfYJlhik5VeHDTpKkLtQxW+phvTYdNL8yp9XOTEYTEYcxVneEBvqWC+e?=
 =?iso-8859-1?Q?xvWatbV/WWY5//34cK1Jw8EYXdi3JlLToeZjZLCWbMdO/B/aYCXsWUXaEE?=
 =?iso-8859-1?Q?1SwA0I/iOfBntqiECPu2LzaXEH0vQPzqpx9stbApmpG3YPKiJe3FxLGqp7?=
 =?iso-8859-1?Q?KpFz9H0BqUwh10ZnshGAEziEf1q44PgYVMe+sWGWBXkfb6D3HGoEc0sMMm?=
 =?iso-8859-1?Q?Xjb7cl7yjksVqu5CgUD26yF1PTBqTmP3R8VjWjGY0/qlqtJxWiyHxgyCHq?=
 =?iso-8859-1?Q?JZSRkZNa2lsOCp8jda4KIjjdwNpKsnTXiyj/Qlqq5klVdWyrEIW5gxcham?=
 =?iso-8859-1?Q?mcCSxJVoWXmTWUbjDxBtRdzjw0g4yPRW5TbUGf/omlu+PwdGf3QpIeY9w7?=
 =?iso-8859-1?Q?UWwhEi2b82zjoBP0pCgw7KJjf4lM4BvDZrKwCVynyyHj3tPwdYnbqHEc+K?=
 =?iso-8859-1?Q?TwxfWMQ4W2P7qSYAySeMaAGO1uZ4y7fx3acNPSrn3SO5a3hEtRz/DF/m9Z?=
 =?iso-8859-1?Q?fYye124VTqHXM9B6KBAFvviKcK6C8iGhYSJyho6t27j2qUFdBbKMNfXTjg?=
 =?iso-8859-1?Q?TuXYLfYVpQqd/EeUepiCYhHM1oCXnwRQKzIQ0/j9d0K5MbAq3Ceu5CWQ3x?=
 =?iso-8859-1?Q?GxZWdQW50cPMiJroxAl6A82zmlnN5bMeL1Tr6Whaap2Z4VqH91LH7UWfiT?=
 =?iso-8859-1?Q?3e3ExYx8w7+hYEoYdElxJxIZDvWGg+/Th8yt+9UwpO0PnyPPNxDqpGa/wb?=
 =?iso-8859-1?Q?kH41nfw/Wt1aMhmrsCGaZxD8dYr3Vzk9HlNIRRmC4IZ4aquxY7W2TVMxiT?=
 =?iso-8859-1?Q?YDuEgMLzpxtY/9JImT1ZoruwNHymbx0yEeUhy2wwpcJzFe0ea9JWTZ7Uvl?=
 =?iso-8859-1?Q?o19VJWYEwpl8vmb6LJ1t2SonwxHLfVLjj2XZwkBenQetqE3/sgbq+XEBfP?=
 =?iso-8859-1?Q?GS+76sf/gUPDe0VPi8V02DdiIzS96dmfWchcOmbwme+y3xylF4D4CeptKG?=
 =?iso-8859-1?Q?m3SQlKiTaL/Iqv16LXTj6nCd8cAn1tSu9JK1LmmJ3ULH8SRRz/PlnZciTe?=
 =?iso-8859-1?Q?+zLwXm56slSDBkS9GtIS6wNKoOUhDXwd7w6wDu4bTemRNtlc6d4chc68m2?=
 =?iso-8859-1?Q?w8YiyG8Bf9PQSS8CannstsPI1eoqE4XRKxPwVU7ddUmzvWwPNMznct9eAi?=
 =?iso-8859-1?Q?V/9vyb/bwhoQkVcycKtBGqOTqSYARsBBWf+H6x/mRUbzeZKYeotlzGPNUg?=
 =?iso-8859-1?Q?gXiKprkn+iCtmDtUrz7aLFUMi4/vxEyPRrdKR04mGTiiJhLA6ppxk2eav4?=
 =?iso-8859-1?Q?PEsIa6XXUMI7wxZN79gT21vsQ8N8/55+9j5IGtviTWpNIQ4bOkO+NJucHD?=
 =?iso-8859-1?Q?gOaDCBhwTKxuonMCSGeV7Ucm36sN6uqMkX7/rg1b0Ki+XZvgwu/OuP3GPX?=
 =?iso-8859-1?Q?b5qVKT1cnIlQnrexHBDzbr3No0qdv3R8LDuhMf+Ic4Kao/mpMlGZGikd4o?=
 =?iso-8859-1?Q?2nVw/QDrpov4TTJqAIhj7OUVIoUDSgZKag/jfAxCuR9pAz10gv9uyX3dMS?=
 =?iso-8859-1?Q?jHgza6VbgG/dhzrlmbSUll2VgAcoHloc5pFNe2JkH/NFlFl58DguZexmBm?=
 =?iso-8859-1?Q?hSDsWXmQjLh5HrvWvZXITbInOetPmiaF2FDHbhxlpyAIhina9ETfxxJAjx?=
 =?iso-8859-1?Q?Xz0Q9qGir3/v7yokkqZRLOTo+Lz4D15AKjeeQkpP1/DmqNKa0fEHoVQiZd?=
 =?iso-8859-1?Q?o3IeciBDJMVfqIHBiGse3o5p292Flek0qQmoyg31JzsmOu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR04MB5651.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb511a9-79fc-4297-7531-08def0998d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 13:25:42.4489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wKnRLE42hcCwVHvNjgnpRA+UgyGgCKuEMux+SEMxhM9gsmyDf2lCju+7n/PmbhP7fZtF14IjWP+4N5CLZcGLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR04MB9320

From: Pu Hu <hupu@transsion.com>=0A=
=0A=
The brief description of the idle-cycles-frontend legacy hardware event=0A=
refers to its alias as "stalled-cycles-fronted", but there is no such=0A=
event. The correct event name is "stalled-cycles-frontend".=0A=
=0A=
This typo is visible in the output of "perf list", for example:=0A=
=0A=
  idle-cycles-frontend=0A=
       [Stalled cycles during issue [This event is an alias of=0A=
        stalled-cycles-fronted]. Unit: armv8_pmuv3]=0A=
=0A=
Fix the spelling so that the description points to the valid event name.=0A=
=0A=
Signed-off-by: Pu Hu <hupu@transsion.com>=0A=
---=0A=
 .../arch/common/common/legacy-hardware.json   |   2 +-=0A=
 tools/perf/pmu-events/empty-pmu-events.c      | 362 +++++++++---------=0A=
 2 files changed, 182 insertions(+), 182 deletions(-)=0A=
=0A=
diff --git a/tools/perf/pmu-events/arch/common/common/legacy-hardware.json =
b/tools/perf/pmu-events/arch/common/common/legacy-hardware.json=0A=
index 71700647f19b..ee9f4247e8ae 100644=0A=
--- a/tools/perf/pmu-events/arch/common/common/legacy-hardware.json=0A=
+++ b/tools/perf/pmu-events/arch/common/common/legacy-hardware.json=0A=
@@ -51,7 +51,7 @@=0A=
   },=0A=
   {=0A=
     "EventName": "idle-cycles-frontend",=0A=
-    "BriefDescription": "Stalled cycles during issue [This event is an ali=
as of stalled-cycles-fronted].",=0A=
+    "BriefDescription": "Stalled cycles during issue [This event is an ali=
as of stalled-cycles-frontend].",=0A=
     "LegacyConfigCode": "7"=0A=
   },=0A=
   {=0A=
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-even=
ts/empty-pmu-events.c=0A=
index 2af4865713be..7df1552403e7 100644=0A=
--- a/tools/perf/pmu-events/empty-pmu-events.c=0A=
+++ b/tools/perf/pmu-events/empty-pmu-events.c=0A=
@@ -2474,186 +2474,186 @@ static const char *const big_c_string =3D=0A=
 /* offset=3D122795 */=0A=
 "stalled-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This event is an alias of idle-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"=0A=
 /* offset=3D122945 */=0A=
-"idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue [T=
his event is an alias of stalled-cycles-fronted]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"=0A=
-/* offset=3D123094 */=0A=
+"idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue [T=
his event is an alias of stalled-cycles-frontend]\000legacy-hardware-config=
=3D7\000\00000\000\000\000\000\000"=0A=
+/* offset=3D123095 */=0A=
 "stalled-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This event is an alias of idle-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"=0A=
-/* offset=3D123247 */=0A=
+/* offset=3D123248 */=0A=
 "idle-cycles-backend\000legacy hardware\000Stalled cycles during retiremen=
t [This event is an alias of stalled-cycles-backend]\000legacy-hardware-con=
fig=3D8\000\00000\000\000\000\000\000"=0A=
-/* offset=3D123400 */=0A=
+/* offset=3D123401 */=0A=
 "ref-cycles\000legacy hardware\000Total cycles; not affected by CPU freque=
ncy scaling\000legacy-hardware-config=3D9\000\00000\000\000\000\000\000"=0A=
-/* offset=3D123512 */=0A=
+/* offset=3D123513 */=0A=
 "software\000"=0A=
-/* offset=3D123521 */=0A=
+/* offset=3D123522 */=0A=
 "cpu-clock\000software\000Per-CPU high-resolution timer based event\000con=
fig=3D0\000\000001e-6msec\000\000\000\000\000"=0A=
-/* offset=3D123607 */=0A=
+/* offset=3D123608 */=0A=
 "task-clock\000software\000Per-task high-resolution timer based event\000c=
onfig=3D1\000\000001e-6msec\000\000\000\000\000"=0A=
-/* offset=3D123695 */=0A=
+/* offset=3D123696 */=0A=
 "faults\000software\000Number of page faults [This event is an alias of pa=
ge-faults]\000config=3D2\000\00000\000\000\000\000\000"=0A=
-/* offset=3D123790 */=0A=
+/* offset=3D123791 */=0A=
 "page-faults\000software\000Number of page faults [This event is an alias =
of faults]\000config=3D2\000\00000\000\000\000\000\000"=0A=
-/* offset=3D123885 */=0A=
+/* offset=3D123886 */=0A=
 "context-switches\000software\000Number of context switches [This event is=
 an alias of cs]\000config=3D3\000\00000\000\000\000\000\000"=0A=
-/* offset=3D123986 */=0A=
+/* offset=3D123987 */=0A=
 "cs\000software\000Number of context switches [This event is an alias of c=
ontext-switches]\000config=3D3\000\00000\000\000\000\000\000"=0A=
-/* offset=3D124087 */=0A=
+/* offset=3D124088 */=0A=
 "cpu-migrations\000software\000Number of times a process has migrated to a=
 new CPU [This event is an alias of migrations]\000config=3D4\000\00000\000=
\000\000\000\000"=0A=
-/* offset=3D124219 */=0A=
+/* offset=3D124220 */=0A=
 "migrations\000software\000Number of times a process has migrated to a new=
 CPU [This event is an alias of cpu-migrations]\000config=3D4\000\00000\000=
\000\000\000\000"=0A=
-/* offset=3D124351 */=0A=
+/* offset=3D124352 */=0A=
 "minor-faults\000software\000Number of minor page faults. Minor faults don=
't require I/O to handle\000config=3D5\000\00000\000\000\000\000\000"=0A=
-/* offset=3D124460 */=0A=
+/* offset=3D124461 */=0A=
 "major-faults\000software\000Number of major page faults. Major faults req=
uire I/O to handle\000config=3D6\000\00000\000\000\000\000\000"=0A=
-/* offset=3D124563 */=0A=
+/* offset=3D124564 */=0A=
 "alignment-faults\000software\000Number of kernel handled memory alignment=
 faults\000config=3D7\000\00000\000\000\000\000\000"=0A=
-/* offset=3D124655 */=0A=
+/* offset=3D124656 */=0A=
 "emulation-faults\000software\000Number of kernel handled unimplemented in=
struction faults handled through emulation\000config=3D8\000\00000\000\000\=
000\000\000"=0A=
-/* offset=3D124782 */=0A=
+/* offset=3D124783 */=0A=
 "dummy\000software\000A placeholder event that doesn't count anything\000c=
onfig=3D9\000\00000\000\000\000\000\000"=0A=
-/* offset=3D124862 */=0A=
+/* offset=3D124863 */=0A=
 "bpf-output\000software\000An event used by BPF programs to write to the p=
erf ring buffer\000config=3D0xa\000\00000\000\000\000\000\000"=0A=
-/* offset=3D124964 */=0A=
+/* offset=3D124965 */=0A=
 "cgroup-switches\000software\000Number of context switches to a task in a =
different cgroup\000config=3D0xb\000\00000\000\000\000\000\000"=0A=
-/* offset=3D125067 */=0A=
+/* offset=3D125068 */=0A=
 "tool\000"=0A=
-/* offset=3D125072 */=0A=
+/* offset=3D125073 */=0A=
 "duration_time\000tool\000Wall clock interval time in nanoseconds\000confi=
g=3D1\000\00000\000\000\000\000\000"=0A=
-/* offset=3D125148 */=0A=
+/* offset=3D125149 */=0A=
 "user_time\000tool\000User (non-kernel) time in nanoseconds\000config=3D2\=
000\00000\000\000\000\000\000"=0A=
-/* offset=3D125218 */=0A=
+/* offset=3D125219 */=0A=
 "system_time\000tool\000System/kernel time in nanoseconds\000config=3D3\00=
0\00000\000\000\000\000\000"=0A=
-/* offset=3D125286 */=0A=
+/* offset=3D125287 */=0A=
 "has_pmem\000tool\0001 if persistent memory installed otherwise 0\000confi=
g=3D4\000\00000\000\000\000\000\000"=0A=
-/* offset=3D125362 */=0A=
+/* offset=3D125363 */=0A=
 "num_cores\000tool\000Number of cores. A core consists of 1 or more thread=
, with each thread being associated with a logical Linux CPU\000config=3D5\=
000\00000\000\000\000\000\000"=0A=
-/* offset=3D125507 */=0A=
+/* offset=3D125508 */=0A=
 "num_cpus\000tool\000Number of logical Linux CPUs. There may be multiple s=
uch CPUs on a core\000config=3D6\000\00000\000\000\000\000\000"=0A=
-/* offset=3D125610 */=0A=
+/* offset=3D125611 */=0A=
 "num_cpus_online\000tool\000Number of online logical Linux CPUs. There may=
 be multiple such CPUs on a core\000config=3D7\000\00000\000\000\000\000\00=
0"=0A=
-/* offset=3D125727 */=0A=
+/* offset=3D125728 */=0A=
 "num_dies\000tool\000Number of dies. Each die has 1 or more cores\000confi=
g=3D8\000\00000\000\000\000\000\000"=0A=
-/* offset=3D125803 */=0A=
+/* offset=3D125804 */=0A=
 "num_packages\000tool\000Number of packages. Each package has 1 or more di=
e\000config=3D9\000\00000\000\000\000\000\000"=0A=
-/* offset=3D125889 */=0A=
+/* offset=3D125890 */=0A=
 "slots\000tool\000Number of functional units that in parallel can execute =
parts of an instruction\000config=3D0xa\000\00000\000\000\000\000\000"=0A=
-/* offset=3D125999 */=0A=
+/* offset=3D126000 */=0A=
 "smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading) i=
s enable otherwise 0\000config=3D0xb\000\00000\000\000\000\000\000"=0A=
-/* offset=3D126106 */=0A=
+/* offset=3D126107 */=0A=
 "system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) increase=
s per second\000config=3D0xc\000\00000\000\000\000\000\000"=0A=
-/* offset=3D126205 */=0A=
+/* offset=3D126206 */=0A=
 "core_wide\000tool\0001 if not SMT, if SMT are events being gathered on al=
l SMT threads 1 otherwise 0\000config=3D0xd\000\00000\000\000\000\000\000"=
=0A=
-/* offset=3D126319 */=0A=
+/* offset=3D126320 */=0A=
 "target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes\00=
0config=3D0xe\000\00000\000\000\000\000\000"=0A=
-/* offset=3D126403 */=0A=
+/* offset=3D126404 */=0A=
 "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0000=
0\000\000\000\000\000"=0A=
-/* offset=3D126465 */=0A=
+/* offset=3D126466 */=0A=
 "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0000=
0\000\000\000\000\000"=0A=
-/* offset=3D126527 */=0A=
+/* offset=3D126528 */=0A=
 "l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\00000\0=
00\000\000\000Attributable Level 3 cache access, read\000"=0A=
-/* offset=3D126625 */=0A=
+/* offset=3D126626 */=0A=
 "segment_reg_loads.any\000other\000Number of segment register loads\000eve=
nt=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\000\000"=0A=
-/* offset=3D126727 */=0A=
+/* offset=3D126728 */=0A=
 "dispatch_blocked.any\000other\000Memory cluster signals to block micro-op=
 dispatch for any reason\000event=3D9,period=3D200000,umask=3D0x20\000\0000=
0\000\000\000\000\000"=0A=
-/* offset=3D126860 */=0A=
+/* offset=3D126861 */=0A=
 "eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technology (=
EIST) transitions\000event=3D0x3a,period=3D200000\000\00000\000\000\000\000=
\000"=0A=
-/* offset=3D126978 */=0A=
+/* offset=3D126979 */=0A=
 "hisi_sccl,ddrc\000"=0A=
-/* offset=3D126993 */=0A=
+/* offset=3D126994 */=0A=
 "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=3D2\=
000\00000\000\000\000\000\000"=0A=
-/* offset=3D127063 */=0A=
+/* offset=3D127064 */=0A=
 "uncore_cbox\000"=0A=
-/* offset=3D127075 */=0A=
+/* offset=3D127076 */=0A=
 "unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop resul=
ted from L3 Eviction which misses in some processor core\000event=3D0x22,um=
ask=3D0x81\000\00000\000\000\000\000\000"=0A=
-/* offset=3D127229 */=0A=
+/* offset=3D127230 */=0A=
 "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000\00=
0\000\000\000"=0A=
-/* offset=3D127283 */=0A=
+/* offset=3D127284 */=0A=
 "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000\00=
0\000\000\000\000"=0A=
-/* offset=3D127341 */=0A=
+/* offset=3D127342 */=0A=
 "hisi_sccl,l3c\000"=0A=
-/* offset=3D127355 */=0A=
+/* offset=3D127356 */=0A=
 "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7\00=
0\00000\000\000\000\000\000"=0A=
-/* offset=3D127423 */=0A=
+/* offset=3D127424 */=0A=
 "uncore_imc_free_running\000"=0A=
-/* offset=3D127447 */=0A=
+/* offset=3D127448 */=0A=
 "uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000eve=
nt=3D0x12\000\00000\000\000\000\000\000"=0A=
-/* offset=3D127527 */=0A=
+/* offset=3D127528 */=0A=
 "uncore_imc\000"=0A=
-/* offset=3D127538 */=0A=
+/* offset=3D127539 */=0A=
 "uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\000\0=
0000\000\000\000\000\000"=0A=
-/* offset=3D127603 */=0A=
+/* offset=3D127604 */=0A=
 "uncore_sys_ddr_pmu\000"=0A=
-/* offset=3D127622 */=0A=
+/* offset=3D127623 */=0A=
 "sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=3D0=
x2b\000v8\00000\000\000\000\000\000"=0A=
-/* offset=3D127698 */=0A=
+/* offset=3D127699 */=0A=
 "uncore_sys_ccn_pmu\000"=0A=
-/* offset=3D127717 */=0A=
+/* offset=3D127718 */=0A=
 "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=3D0x=
2c\0000x01\00000\000\000\000\000\000"=0A=
-/* offset=3D127794 */=0A=
+/* offset=3D127795 */=0A=
 "uncore_sys_cmn_pmu\000"=0A=
-/* offset=3D127813 */=0A=
+/* offset=3D127814 */=0A=
 "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in firs=
t lookup result (high priority)\000eventid=3D1,type=3D5\000(434|436|43c|43a=
).*\00000\000\000\000\000\000"=0A=
-/* offset=3D127956 */=0A=
+/* offset=3D127957 */=0A=
 "CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@=
 if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (dur=
ation_time * 1e9)\000\000Average CPU utilization\000\0001CPUs\000\000\000\0=
00011"=0A=
-/* offset=3D128142 */=0A=
+/* offset=3D128143 */=0A=
 "cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcontex=
t\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Context=
 switches per CPU second\000\0001cs/sec\000\000\000\000011"=0A=
-/* offset=3D128375 */=0A=
+/* offset=3D128376 */=0A=
 "migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=3D=
cpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if =
#target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Pro=
cess migrations to a new CPU per CPU second\000\0001migrations/sec\000\000\=
000\000011"=0A=
-/* offset=3D128635 */=0A=
+/* offset=3D128636 */=0A=
 "page_faults_per_second\000Default\000software@page\\-faults\\,name\\=3Dpa=
ge\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #targ=
et_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)\000\000Page fau=
lts per CPU second\000\0001faults/sec\000\000\000\000011"=0A=
-/* offset=3D128866 */=0A=
+/* offset=3D128867 */=0A=
 "insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_cycl=
e < 1\000Instructions Per Cycle\000\0001instructions\000\000\000\000001"=0A=
-/* offset=3D128979 */=0A=
+/* offset=3D128980 */=0A=
 "stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-fron=
tend, stalled\\-cycles\\-backend) / instructions if has_event(stalled\\-cyc=
les\\-frontend) & has_event(stalled\\-cycles\\-backend) else (stalled\\-cyc=
les\\-frontend / instructions if has_event(stalled\\-cycles\\-frontend) els=
e (stalled\\-cycles\\-backend / instructions if has_event(stalled\\-cycles\=
\-backend) else 0)))\000\000Max front or backend stalls per instruction\000=
\000\000\000\000\000001"=0A=
-/* offset=3D129404 */=0A=
+/* offset=3D129405 */=0A=
 "frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\\-c=
ycles if has_event(stalled\\-cycles\\-frontend) else 0)\000frontend_cycles_=
idle > 0.1\000Frontend stalls per cycle\000\000\000\000\000\000001"=0A=
-/* offset=3D129583 */=0A=
+/* offset=3D129584 */=0A=
 "backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-cyc=
les if has_event(stalled\\-cycles\\-backend) else 0)\000backend_cycles_idle=
 > 0.2\000Backend stalls per cycle\000\000\000\000\000\000001"=0A=
-/* offset=3D129757 */=0A=
+/* offset=3D129758 */=0A=
 "cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\000\000\000011"=0A=
-/* offset=3D129933 */=0A=
+/* offset=3D129934 */=0A=
 "branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Branches per CPU second\000\0001000M/sec\000\000\000\000011=
"=0A=
-/* offset=3D130113 */=0A=
+/* offset=3D130114 */=0A=
 "branch_miss_rate\000Default\000branch\\-misses / branches\000branch_miss_=
rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000001"=0A=
-/* offset=3D130217 */=0A=
+/* offset=3D130218 */=0A=
 "l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache\\-=
loads\000l1d_miss_rate > 0.05\000L1D  miss rate\000\000100%\000\000\000\000=
001"=0A=
-/* offset=3D130333 */=0A=
+/* offset=3D130334 */=0A=
 "llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_mis=
s_rate > 0.05\000LLC miss rate\000\000100%\000\000\000\000001"=0A=
-/* offset=3D130434 */=0A=
+/* offset=3D130435 */=0A=
 "l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache\\-=
loads\000l1i_miss_rate > 0.05\000L1I miss rate\000\000100%\000\000\000\0000=
01"=0A=
-/* offset=3D130549 */=0A=
+/* offset=3D130550 */=0A=
 "dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000dtlb=
_miss_rate > 0.05\000dTLB miss rate\000\000100%\000\000\000\000001"=0A=
-/* offset=3D130655 */=0A=
+/* offset=3D130656 */=0A=
 "itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000itlb=
_miss_rate > 0.05\000iTLB miss rate\000\000100%\000\000\000\000001"=0A=
-/* offset=3D130761 */=0A=
+/* offset=3D130762 */=0A=
 "l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses / L1=
\\-dcache\\-prefetches\000l1_prefetch_miss_rate > 0.05\000L1 prefetch miss =
rate\000\000100%\000\000\000\000001"=0A=
-/* offset=3D130909 */=0A=
+/* offset=3D130910 */=0A=
 "CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000"=0A=
-/* offset=3D130932 */=0A=
+/* offset=3D130933 */=0A=
 "IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\000\0=
00\000\000\000\000000"=0A=
-/* offset=3D130996 */=0A=
+/* offset=3D130997 */=0A=
 "Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_unh=
alted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalt=
ed.ref_xclk)))\000\000\000\000\000\000\000\000000"=0A=
-/* offset=3D131163 */=0A=
+/* offset=3D131164 */=0A=
 "dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\00=
0\000\000\000\000\000000"=0A=
-/* offset=3D131228 */=0A=
+/* offset=3D131229 */=0A=
 "icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000=
\000\000\000\000\000\000000"=0A=
-/* offset=3D131296 */=0A=
+/* offset=3D131297 */=0A=
 "cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\0=
00\000\000\000\000\000\000000"=0A=
-/* offset=3D131368 */=0A=
+/* offset=3D131369 */=0A=
 "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit +=
 l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000000"=0A=
-/* offset=3D131463 */=0A=
+/* offset=3D131464 */=0A=
 "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.dema=
nd_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\000\000\000\000\0=
00\000\000\000000"=0A=
-/* offset=3D131598 */=0A=
+/* offset=3D131599 */=0A=
 "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\000\=
000\000\000\000\000000"=0A=
-/* offset=3D131663 */=0A=
+/* offset=3D131664 */=0A=
 "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\000\=
000\000\000\000\000\000000"=0A=
-/* offset=3D131732 */=0A=
+/* offset=3D131733 */=0A=
 "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000\00=
0\000\000\000\000\000\000000"=0A=
-/* offset=3D131803 */=0A=
+/* offset=3D131804 */=0A=
 "M1\000\000ipc + M2\000\000\000\000\000\000\000\000000"=0A=
-/* offset=3D131826 */=0A=
+/* offset=3D131827 */=0A=
 "M2\000\000ipc + M1\000\000\000\000\000\000\000\000000"=0A=
-/* offset=3D131849 */=0A=
+/* offset=3D131850 */=0A=
 "M3\000\0001 / M3\000\000\000\000\000\000\000\000000"=0A=
-/* offset=3D131870 */=0A=
+/* offset=3D131871 */=0A=
 "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\000\0=
00\000\000\000\000\000\000000"=0A=
 ;=0A=
 =0A=
@@ -3469,7 +3469,7 @@ static const struct compact_pmu_event pmu_events__com=
mon_default_core[] =3D {=0A=
 	/* i-tlb-refs\000legacy cache\000Instruction TLB read accesses\000legacy-=
cache-conf... */=0A=
 	{ 97543 },=0A=
 	/* idle-cycles-backend\000legacy hardware\000Stalled cycles during retire=
ment [This... */=0A=
-	{ 123247 },=0A=
+	{ 123248 },=0A=
 	/* idle-cycles-frontend\000legacy hardware\000Stalled cycles during issue=
 [This eve... */=0A=
 	{ 122945 },=0A=
 	/* instruction-tlb\000legacy cache\000Instruction TLB read accesses\000le=
gacy-cache... */=0A=
@@ -5113,73 +5113,73 @@ static const struct compact_pmu_event pmu_events__c=
ommon_default_core[] =3D {=0A=
 	/* node-write-refs\000legacy cache\000Local memory write accesses\000lega=
cy-cache-c... */=0A=
 	{ 117401 },=0A=
 	/* ref-cycles\000legacy hardware\000Total cycles; not affected by CPU fre=
quency sca... */=0A=
-	{ 123400 },=0A=
+	{ 123401 },=0A=
 	/* stalled-cycles-backend\000legacy hardware\000Stalled cycles during ret=
irement [T... */=0A=
-	{ 123094 },=0A=
+	{ 123095 },=0A=
 	/* stalled-cycles-frontend\000legacy hardware\000Stalled cycles during is=
sue [This ... */=0A=
 	{ 122795 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__common_software[] =3D {=
=0A=
 	/* alignment-faults\000software\000Number of kernel handled memory alignm=
ent faults... */=0A=
-	{ 124563 },=0A=
+	{ 124564 },=0A=
 	/* bpf-output\000software\000An event used by BPF programs to write to th=
e perf rin... */=0A=
-	{ 124862 },=0A=
+	{ 124863 },=0A=
 	/* cgroup-switches\000software\000Number of context switches to a task in=
 a differe... */=0A=
-	{ 124964 },=0A=
+	{ 124965 },=0A=
 	/* context-switches\000software\000Number of context switches [This event=
 is an ali... */=0A=
-	{ 123885 },=0A=
+	{ 123886 },=0A=
 	/* cpu-clock\000software\000Per-CPU high-resolution timer based event\000=
config=3D0\0... */=0A=
-	{ 123521 },=0A=
+	{ 123522 },=0A=
 	/* cpu-migrations\000software\000Number of times a process has migrated t=
o a new CP... */=0A=
-	{ 124087 },=0A=
+	{ 124088 },=0A=
 	/* cs\000software\000Number of context switches [This event is an alias o=
f context-... */=0A=
-	{ 123986 },=0A=
+	{ 123987 },=0A=
 	/* dummy\000software\000A placeholder event that doesn't count anything\0=
00config=3D9... */=0A=
-	{ 124782 },=0A=
+	{ 124783 },=0A=
 	/* emulation-faults\000software\000Number of kernel handled unimplemented=
 instructi... */=0A=
-	{ 124655 },=0A=
+	{ 124656 },=0A=
 	/* faults\000software\000Number of page faults [This event is an alias of=
 page-faul... */=0A=
-	{ 123695 },=0A=
+	{ 123696 },=0A=
 	/* major-faults\000software\000Number of major page faults. Major faults =
require I/... */=0A=
-	{ 124460 },=0A=
+	{ 124461 },=0A=
 	/* migrations\000software\000Number of times a process has migrated to a =
new CPU [T... */=0A=
-	{ 124219 },=0A=
+	{ 124220 },=0A=
 	/* minor-faults\000software\000Number of minor page faults. Minor faults =
don't requ... */=0A=
-	{ 124351 },=0A=
+	{ 124352 },=0A=
 	/* page-faults\000software\000Number of page faults [This event is an ali=
as of faul... */=0A=
-	{ 123790 },=0A=
+	{ 123791 },=0A=
 	/* task-clock\000software\000Per-task high-resolution timer based event\0=
00config=3D1... */=0A=
-	{ 123607 },=0A=
+	{ 123608 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__common_tool[] =3D {=0A=
 	/* core_wide\000tool\0001 if not SMT, if SMT are events being gathered on=
 all SMT t... */=0A=
-	{ 126205 },=0A=
+	{ 126206 },=0A=
 	/* duration_time\000tool\000Wall clock interval time in nanoseconds\000co=
nfig=3D1\000... */=0A=
-	{ 125072 },=0A=
+	{ 125073 },=0A=
 	/* has_pmem\000tool\0001 if persistent memory installed otherwise 0\000co=
nfig=3D4\000... */=0A=
-	{ 125286 },=0A=
+	{ 125287 },=0A=
 	/* num_cores\000tool\000Number of cores. A core consists of 1 or more thr=
ead, with ... */=0A=
-	{ 125362 },=0A=
+	{ 125363 },=0A=
 	/* num_cpus\000tool\000Number of logical Linux CPUs. There may be multipl=
e such CPU... */=0A=
-	{ 125507 },=0A=
+	{ 125508 },=0A=
 	/* num_cpus_online\000tool\000Number of online logical Linux CPUs. There =
may be mul... */=0A=
-	{ 125610 },=0A=
+	{ 125611 },=0A=
 	/* num_dies\000tool\000Number of dies. Each die has 1 or more cores\000co=
nfig=3D8\000... */=0A=
-	{ 125727 },=0A=
+	{ 125728 },=0A=
 	/* num_packages\000tool\000Number of packages. Each package has 1 or more=
 die\000co... */=0A=
-	{ 125803 },=0A=
+	{ 125804 },=0A=
 	/* slots\000tool\000Number of functional units that in parallel can execu=
te parts o... */=0A=
-	{ 125889 },=0A=
+	{ 125890 },=0A=
 	/* smt_on\000tool\0001 if simultaneous multithreading (aka hyperthreading=
) is enabl... */=0A=
-	{ 125999 },=0A=
+	{ 126000 },=0A=
 	/* system_time\000tool\000System/kernel time in nanoseconds\000config=3D3=
\000\00000\0... */=0A=
-	{ 125218 },=0A=
+	{ 125219 },=0A=
 	/* system_tsc_freq\000tool\000The amount a Time Stamp Counter (TSC) incre=
ases per s... */=0A=
-	{ 126106 },=0A=
+	{ 126107 },=0A=
 	/* target_cpu\000tool\0001 if CPUs being analyzed, 0 if threads/processes=
\000config... */=0A=
-	{ 126319 },=0A=
+	{ 126320 },=0A=
 	/* user_time\000tool\000User (non-kernel) time in nanoseconds\000config=
=3D2\000\00000... */=0A=
-	{ 125148 },=0A=
+	{ 125149 },=0A=
 =0A=
 };=0A=
 =0A=
@@ -5192,50 +5192,50 @@ static const struct pmu_table_entry pmu_events__com=
mon[] =3D {=0A=
 	{=0A=
 		.entries =3D pmu_events__common_software,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__common_software),=0A=
-		.pmu_name =3D { 123512 /* software\000 */ },=0A=
+		.pmu_name =3D { 123513 /* software\000 */ },=0A=
 	},=0A=
 	{=0A=
 		.entries =3D pmu_events__common_tool,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__common_tool),=0A=
-		.pmu_name =3D { 125067 /* tool\000 */ },=0A=
+		.pmu_name =3D { 125068 /* tool\000 */ },=0A=
 	},=0A=
 };=0A=
 =0A=
 static const struct compact_pmu_event pmu_metrics__common_default_core[] =
=3D {=0A=
 	/* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\\=3Dcpu\\-clo=
ck@ if #targ... */=0A=
-	{ 127956 },=0A=
+	{ 127957 },=0A=
 	/* backend_cycles_idle\000Default\000(stalled\\-cycles\\-backend / cpu\\-=
cycles if ... */=0A=
-	{ 129583 },=0A=
+	{ 129584 },=0A=
 	/* branch_frequency\000Default\000branches / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-c... */=0A=
-	{ 129933 },=0A=
+	{ 129934 },=0A=
 	/* branch_miss_rate\000Default\000branch\\-misses / branches\000branch_mi=
ss_rate > ... */=0A=
-	{ 130113 },=0A=
+	{ 130114 },=0A=
 	/* cs_per_second\000Default\000software@context\\-switches\\,name\\=3Dcon=
text\\-switc... */=0A=
-	{ 128142 },=0A=
+	{ 128143 },=0A=
 	/* cycles_frequency\000Default\000cpu\\-cycles / (software@cpu\\-clock\\,=
name\\=3Dcpu... */=0A=
-	{ 129757 },=0A=
+	{ 129758 },=0A=
 	/* dtlb_miss_rate\000Default3\000dTLB\\-load\\-misses / dTLB\\-loads\000d=
tlb_miss_r... */=0A=
-	{ 130549 },=0A=
+	{ 130550 },=0A=
 	/* frontend_cycles_idle\000Default\000(stalled\\-cycles\\-frontend / cpu\=
\-cycles i... */=0A=
-	{ 129404 },=0A=
+	{ 129405 },=0A=
 	/* insn_per_cycle\000Default\000instructions / cpu\\-cycles\000insn_per_c=
ycle < 1\0... */=0A=
-	{ 128866 },=0A=
+	{ 128867 },=0A=
 	/* itlb_miss_rate\000Default3\000iTLB\\-load\\-misses / iTLB\\-loads\000i=
tlb_miss_r... */=0A=
-	{ 130655 },=0A=
+	{ 130656 },=0A=
 	/* l1_prefetch_miss_rate\000Default4\000L1\\-dcache\\-prefetch\\-misses /=
 L1\\-dcac... */=0A=
-	{ 130761 },=0A=
+	{ 130762 },=0A=
 	/* l1d_miss_rate\000Default2\000L1\\-dcache\\-load\\-misses / L1\\-dcache=
\\-loads\0... */=0A=
-	{ 130217 },=0A=
+	{ 130218 },=0A=
 	/* l1i_miss_rate\000Default3\000L1\\-icache\\-load\\-misses / L1\\-icache=
\\-loads\0... */=0A=
-	{ 130434 },=0A=
+	{ 130435 },=0A=
 	/* llc_miss_rate\000Default2\000LLC\\-load\\-misses / LLC\\-loads\000llc_=
miss_rate ... */=0A=
-	{ 130333 },=0A=
+	{ 130334 },=0A=
 	/* migrations_per_second\000Default\000software@cpu\\-migrations\\,name\\=
=3Dcpu\\-mig... */=0A=
-	{ 128375 },=0A=
+	{ 128376 },=0A=
 	/* page_faults_per_second\000Default\000software@page\\-faults\\,name\\=
=3Dpage\\-faul... */=0A=
-	{ 128635 },=0A=
+	{ 128636 },=0A=
 	/* stalled_cycles_per_instruction\000Default\000(max(stalled\\-cycles\\-f=
rontend, s... */=0A=
-	{ 128979 },=0A=
+	{ 128980 },=0A=
 =0A=
 };=0A=
 =0A=
@@ -5249,41 +5249,41 @@ static const struct pmu_table_entry pmu_metrics__co=
mmon[] =3D {=0A=
 =0A=
 static const struct compact_pmu_event pmu_events__test_soc_cpu_default_cor=
e[] =3D {=0A=
 	/* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=3D0x8a\000\0=
0000\000\000... */=0A=
-	{ 126403 },=0A=
+	{ 126404 },=0A=
 	/* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=3D0x8b\000\0=
0000\000\000... */=0A=
-	{ 126465 },=0A=
+	{ 126466 },=0A=
 	/* dispatch_blocked.any\000other\000Memory cluster signals to block micro=
-op dispat... */=0A=
-	{ 126727 },=0A=
+	{ 126728 },=0A=
 	/* eist_trans\000other\000Number of Enhanced Intel SpeedStep(R) Technolog=
y (EIST) t... */=0A=
-	{ 126860 },=0A=
+	{ 126861 },=0A=
 	/* l3_cache_rd\000cache\000L3 cache access, read\000event=3D0x40\000\0000=
0\000\000\00... */=0A=
-	{ 126527 },=0A=
+	{ 126528 },=0A=
 	/* segment_reg_loads.any\000other\000Number of segment register loads\000=
event=3D6,pe... */=0A=
-	{ 126625 },=0A=
+	{ 126626 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_d=
drc[] =3D {=0A=
 	/* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write commands\000event=
=3D2\000\00000... */=0A=
-	{ 126993 },=0A=
+	{ 126994 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl_l=
3c[] =3D {=0A=
 	/* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits\000event=3D7=
\000\00000\0... */=0A=
-	{ 127355 },=0A=
+	{ 127356 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cbox=
[] =3D {=0A=
 	/* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\000\00000\000=
\000\000\000... */=0A=
-	{ 127229 },=0A=
+	{ 127230 },=0A=
 	/* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0xc0\000\00000=
\000\000\000... */=0A=
-	{ 127283 },=0A=
+	{ 127284 },=0A=
 	/* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-core snoop re=
sulted fro... */=0A=
-	{ 127075 },=0A=
+	{ 127076 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc[=
] =3D {=0A=
 	/* uncore_imc.cache_hits\000uncore\000Total cache hits\000event=3D0x34\00=
0\00000\000\... */=0A=
-	{ 127538 },=0A=
+	{ 127539 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_imc_=
free_running[] =3D {=0A=
 	/* uncore_imc_free_running.cache_miss\000uncore\000Total cache misses\000=
event=3D0x12... */=0A=
-	{ 127447 },=0A=
+	{ 127448 },=0A=
 =0A=
 };=0A=
 =0A=
@@ -5296,61 +5296,61 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_cpu[] =3D {=0A=
 	{=0A=
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc),=0A=
-		.pmu_name =3D { 126978 /* hisi_sccl,ddrc\000 */ },=0A=
+		.pmu_name =3D { 126979 /* hisi_sccl,ddrc\000 */ },=0A=
 	},=0A=
 	{=0A=
 		.entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c),=0A=
-		.pmu_name =3D { 127341 /* hisi_sccl,l3c\000 */ },=0A=
+		.pmu_name =3D { 127342 /* hisi_sccl,l3c\000 */ },=0A=
 	},=0A=
 	{=0A=
 		.entries =3D pmu_events__test_soc_cpu_uncore_cbox,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),=0A=
-		.pmu_name =3D { 127063 /* uncore_cbox\000 */ },=0A=
+		.pmu_name =3D { 127064 /* uncore_cbox\000 */ },=0A=
 	},=0A=
 	{=0A=
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),=0A=
-		.pmu_name =3D { 127527 /* uncore_imc\000 */ },=0A=
+		.pmu_name =3D { 127528 /* uncore_imc\000 */ },=0A=
 	},=0A=
 	{=0A=
 		.entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_free_run=
ning),=0A=
-		.pmu_name =3D { 127423 /* uncore_imc_free_running\000 */ },=0A=
+		.pmu_name =3D { 127424 /* uncore_imc_free_running\000 */ },=0A=
 	},=0A=
 };=0A=
 =0A=
 static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_co=
re[] =3D {=0A=
 	/* CPI\000\0001 / IPC\000\000\000\000\000\000\000\000000 */=0A=
-	{ 130909 },=0A=
+	{ 130910 },=0A=
 	/* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_Miss\000\000\0=
00\000\000... */=0A=
-	{ 131598 },=0A=
+	{ 131599 },=0A=
 	/* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hi=
t + l2_rqs... */=0A=
-	{ 131368 },=0A=
+	{ 131369 },=0A=
 	/* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd - l2_rqsts.d=
emand_data... */=0A=
-	{ 131463 },=0A=
+	{ 131464 },=0A=
 	/* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_L2_All)\000\0=
00\000\000... */=0A=
-	{ 131663 },=0A=
+	{ 131664 },=0A=
 	/* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCache_L2_All)\000=
\000\000\0... */=0A=
-	{ 131732 },=0A=
+	{ 131733 },=0A=
 	/* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (4 * (cpu_clk_=
unhalted.t... */=0A=
-	{ 130996 },=0A=
+	{ 130997 },=0A=
 	/* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thread\000\000\00=
0\000\000\... */=0A=
-	{ 130932 },=0A=
+	{ 130933 },=0A=
 	/* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / duration_time\00=
0\000\000\... */=0A=
-	{ 131870 },=0A=
+	{ 131871 },=0A=
 	/* M1\000\000ipc + M2\000\000\000\000\000\000\000\000000 */=0A=
-	{ 131803 },=0A=
+	{ 131804 },=0A=
 	/* M2\000\000ipc + M1\000\000\000\000\000\000\000\000000 */=0A=
-	{ 131826 },=0A=
+	{ 131827 },=0A=
 	/* M3\000\0001 / M3\000\000\000\000\000\000\000\000000 */=0A=
-	{ 131849 },=0A=
+	{ 131850 },=0A=
 	/* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\00=
0\000\000\... */=0A=
-	{ 131296 },=0A=
+	{ 131297 },=0A=
 	/* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000=
\000\000\0... */=0A=
-	{ 131163 },=0A=
+	{ 131164 },=0A=
 	/* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\=
000\000\00... */=0A=
-	{ 131228 },=0A=
+	{ 131229 },=0A=
 =0A=
 };=0A=
 =0A=
@@ -5364,15 +5364,15 @@ static const struct pmu_table_entry pmu_metrics__te=
st_soc_cpu[] =3D {=0A=
 =0A=
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ccn_pmu[] =3D {=0A=
 	/* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles event\000config=
=3D0x2c\0000x0... */=0A=
-	{ 127717 },=0A=
+	{ 127718 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
cmn_pmu[] =3D {=0A=
 	/* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cache misses in f=
irst looku... */=0A=
-	{ 127813 },=0A=
+	{ 127814 },=0A=
 };=0A=
 static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sys_=
ddr_pmu[] =3D {=0A=
 	/* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles event\000event=
=3D0x2b\000v8... */=0A=
-	{ 127622 },=0A=
+	{ 127623 },=0A=
 =0A=
 };=0A=
 =0A=
@@ -5380,17 +5380,17 @@ static const struct pmu_table_entry pmu_events__tes=
t_soc_sys[] =3D {=0A=
 	{=0A=
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn_pmu)=
,=0A=
-		.pmu_name =3D { 127698 /* uncore_sys_ccn_pmu\000 */ },=0A=
+		.pmu_name =3D { 127699 /* uncore_sys_ccn_pmu\000 */ },=0A=
 	},=0A=
 	{=0A=
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn_pmu)=
,=0A=
-		.pmu_name =3D { 127794 /* uncore_sys_cmn_pmu\000 */ },=0A=
+		.pmu_name =3D { 127795 /* uncore_sys_cmn_pmu\000 */ },=0A=
 	},=0A=
 	{=0A=
 		.entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,=0A=
 		.num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr_pmu)=
,=0A=
-		.pmu_name =3D { 127603 /* uncore_sys_ddr_pmu\000 */ },=0A=
+		.pmu_name =3D { 127604 /* uncore_sys_ddr_pmu\000 */ },=0A=
 	},=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
