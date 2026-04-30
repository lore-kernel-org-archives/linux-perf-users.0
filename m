Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC75274B3B;
	Thu, 30 Apr 2026 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.38.203.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577241; cv=fail; b=ARGr//q4BMl1EibUMnwpxLyslfeXTz7skSsc5zM6hcjajpQN1XEsW3VkcLGeHJEl6xXdqGzwb2z2BRkUmyiSjYD3cLO8YfgmL6cVLor4Uet21uc8s0SLqbVVcdQB7uPBR+ajWAqL/FK/02z6gDLxsu71l2a5Y6VSpJZjv1Mcu8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577241; c=relaxed/simple;
	bh=n6U/fSsX15DqbGbwK1Wo2gYJTEcR8Bx0Mq6XHMjIP9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gbp1C/scIvPf1LDvaiUzpQt72vLlQNdnMYLROakypz/oMyV4I1vcLePz3jlKOhHpiPzRORdgn1XiRQJgn3JYPgcItcrCnCBshRTxcMlTcYS6YOv0ioGkz440I1i3FT7LIF6gipr0JB/665FaYgeLk8r6ZXc4qe1tcju+5b567CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Ea53AVh0; arc=fail smtp.client-ip=173.38.203.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="Ea53AVh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2694; q=dns/txt;
  s=iport01; t=1777577239; x=1778786839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=n6U/fSsX15DqbGbwK1Wo2gYJTEcR8Bx0Mq6XHMjIP9I=;
  b=Ea53AVh0Sk+0A9Xvs92Wx3k7xohpE0/9UiIUPXU2WZ5ABVvM2e61GHAK
   MeVjjdahbieb2v38vbqio0Lvw0Yz43qqQhhSSjI7Z+mbslvZUlRfMqAqg
   2MrVCNeWUr62+KSaO3v1Hspgp8hhoqKNhyMc3V6aC32/jB6LRtUfmArjd
   tuhs471rBw08xHUBVxQfoGtb4Yi/6J5XazS+/tf/waNC0SGOhKmPbID0p
   izw/7SVu2HiKjsPggSlKRdbDCEH2Ssv8o/bFiWSJYqx+93KhHi/DX7TFs
   7icbJAD6x+37RBQf4lo1Iqgpt7DVNt9Yc2t5BxBqddfygYM9kh/mEIu7B
   Q==;
X-CSE-ConnectionGUID: uteS1pSsTPO1tj3BqRO3oA==
X-CSE-MsgGUID: iq2n89huQG+/FUAnSmNKWg==
X-IPAS-Result: =?us-ascii?q?A0BpBQDpq/Np/9VK/pBaHgEBCxIMZYMZKimCKEmEV4NMA?=
 =?us-ascii?q?4UshliCIQOFeoxxjS4PAQEBDQJRBAEBghKCdAIWjRsCJjgTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZbAQEBAxIREUUQAgEIGAICJ?=
 =?us-ascii?q?gICAg4hFRACBA4FIoVUAwECqCgBgT0Ciip6gTKBAeAwFQWBBS6IWAGBcIkAJ?=
 =?us-ascii?q?xuBSUSEPz6EQ4NbgmkEgiKBDoMNjBYJSXgcA1ksAUsKNQwzLkJDA4EpDzwFN?=
 =?us-ascii?q?2USPyEdLB85AjgHBRIhERlugRR0IQtcGg4hJBE0BCFCOFQFgXACdoEmGV8jL?=
 =?us-ascii?q?wNObwN4PTcUGwQ9i2EeD4MqDgWBbwJtk2qCc0mPfZ9ZCoQcojiDcZQVklIum?=
 =?us-ascii?q?FikAIUWAgQCBAUCEAEBBoF/JYFZcBWDIlMZD44tFoEUAQ7GfXg9AgcCBw0DC?=
 =?us-ascii?q?5NlAQE?=
IronPort-PHdr: A9a23:QKIMSB0PtMugQ5EVsmDPmlBlVkEcU/3cJAUZ7N8gk71RN/7l9JX5N
 0uZ7vJo3xfFXoTevupNkPGe87vhVmoJ/YubvTgcfYZNWR4IhYRenwEpDMOfT0yuBPXrdCc9W
 s9FUTdY
IronPort-Data: A9a23:pYzCLq6Iu2tc6EJqZEVwXAxRtCjGchMFZxGqfqrLsTDasY5as4F+v
 jFJCGiBP/fZYWTzL91xaoy3p0wDv8TXyNJnGgE9/C8xZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo+KUzBHf/g2Qqaj5Ps/rawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eIJEVwb9vOnpyz
 dtBNDJWRAm5oLmx6efuIgVsrpxLwMjDNY4F/3UlxjbDALN/G9bIQr7B4plT2zJYasJmRKqCI
 ZBENXwwMFKaOkYn1lQ/UPrSmM+kj3/+fjlHoXqepLE85C7YywkZPL3FbYWMI4HaHJ49ckCwp
 3uc+TSoAgwjG5/Y5wes9EmpoMzwknauMG4VPPjinhJwu3WXx2oOGFgVWEG9rP2RlEGzQZRcJ
 lYS9y5oqrI9nGSvT9/gT1igrWSK+wMHVsBLO/M15RvLyafO5QudQG8eQVZpbN0gqd9zWSYj3
 VLMnN7zAzFrmKOaRGjb9bqOqz62fy8PIgc/iTQsRAYfpt2mq4Ypg1eWFJBoEbW+iZv+HjSYL
 y22kRXSTo471KYj/6665lvAxTmro/D0osQdvW07gkrNAttFWbOY
IronPort-HdrOrdr: A9a23:jQiLr6HijGNzaw5LpLqF1JLXdLJyesId70hD6qkvc203TiXIra
 CTdaogtCMc0AxhJk3I+ertBEGBKUmsk6KceeEqTPmftXrdyRqVxeZZnMrfKlzbamLDH4FmpN
 1dmsRFebnN5B1B/LnHCWqDYpYdKbu8gd2VbI7lph8HI3AJGsRdBkVCe3qm+yZNNXB77O8CZe
 GhD7181kKdkBosH6OG71A+Lpv+juyOvqjLJTQBABkq4hSPizSH1J7WeiLz4j4uFxl07fMH62
 bqryzVj5/Pj9iLjjPM3W7a6Jpb3ODm1sZCA8K0jM0UICXHiwqjZohtMofy/wzdptvB1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6xmxLY0InEbQN/L/AEqZNScxPf5UZllsp7yr
 h302WQsIcSJQ/cnR76+8PDW3hR5w6JSDsZ4KkuZk5kINIjgYxq3NQiFYRuYcw99RfBmcYa+S
 9VfZvhDbhtAA6nhjvizxlSKZSXLwYO91G9Mwo/k/3Q9SRKl3ZkyEZd7skeknAcsK8ZcfB/lr
 j52mACrsARcifQBpgNW9spUI+5DHfATgnLN3/XKVP7FLsfM3aIsJLv5q4pjdvaMqDg4aFC0K
 gpamko/lIaagbrE4mDzZdL+hfCTCG0Wins0NhX49x8tqfnTLTmPCWfQBR2+vHQ78k3E4neQb
 K+KZhWC/jsIS/nHptIxRT3X91XJWMFWMMYt94nUxaFo97NKIftquvHGcyjaYbFAHIhQCfyE3
 EDVD/8KIFJ6V2qQGbxhFzLV3bkaiXEjNtN+Wjhjp4uIaQ2R/pxW1Iu+CGED+mwWEl/jpA=
X-Talos-CUID: =?us-ascii?q?9a23=3AXLfSBmsIPJraKmgXc6jJV2zq6Is4bnDmlW/rOHO?=
 =?us-ascii?q?ALj91Sua/UGW3o6RNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ALnzUZg5uleHf3cuoqMwvqxn5xoxp+v6oWBENjKw?=
 =?us-ascii?q?p+I6qCAV2ADK7rwu4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from aer-l-core-12.cisco.com ([144.254.74.213])
  by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Apr 2026 19:26:07 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aer-l-core-12.cisco.com (Postfix) with ESMTPS id E12EA18000AE5;
	Thu, 30 Apr 2026 19:26:06 +0000 (GMT)
X-CSE-ConnectionGUID: PKjPus/PQqKZCKywQt3YaQ==
X-CSE-MsgGUID: B85EaPBjQ3yjILdvOz2cpg==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.23,208,1770595200"; 
   d="scan'208";a="59850953"
Received: from mail-bl2pr08cu00102.outbound.protection.outlook.com (HELO BL2PR08CU001.outbound.protection.outlook.com) ([40.93.4.10])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Apr 2026 19:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3l/S2DeJ4LYIXoFvXWFeTV+x8nJ4xUIzV1cT/KzMnWROq3Yfp1NnS1sdvHLHGuMPNnQu2KxHqCQdwVRmhKtbfCx5mLnZAnrKH9ifDwFteMr6ImDk2gtiuXRHrYVKaU2twzlvy8z/LisfgLDg/HjwbIQmUxwNHTi6lzU4Q48o0kEHxyA6JldISyY5b5pCbyu0jehSoULEPcO8qvUorZoilsPwJkXDrrdrsx4PiQ6+Ck1ChJhSI9i6Xyqg9rY9ahaisUDCGgG8aQfFPVzIZy8jKR92Ix1rUJLuCmys5W5By/MpxMQ7oqB2XhklhwXpTZmS5kc3skwRrPLFihT1YbPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6U/fSsX15DqbGbwK1Wo2gYJTEcR8Bx0Mq6XHMjIP9I=;
 b=H0yAp0WcWlhRqCrU2KYHQc8G4oxiMwaM2jTGU+5DzmjTXavlY88IYAOCpHIHa05nCd2hyhgNw7O7yUTr2h/M5a5qeF4fCyU2KPjeu5x5tEq6qFrt12ajvfc+IwXpI37UbJsbib4goWAoH9ffYk7CpRf3Al2xOoLp/NEMIIJvv5KsoC1dGpv+C063Htr49O8576htoa8OFZ7M2NAEpkVGHFv2kdv+SJDXkQ4v3VpEWZChd6L9KVF4Z39jRbLcwr2MiddFEfmkuYlanntJZizJrGhLp1GdNYrmKB/o/sQDHt3Bo15FNUITCjeq67qHKomHGBb4OnrS8So1pJyUOsDNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 30 Apr
 2026 19:25:59 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::abf2:ab63:49c7:e31b]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::abf2:ab63:49c7:e31b%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 19:25:59 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Jann Horn <jannh@google.com>
CC: Oleg Nesterov <oleg@redhat.com>, "David Hildenbrand (Arm)"
	<david@kernel.org>, "Darko Tominac -X (dtominac - GLOBALLOGIC INC at Cisco)"
	<dtominac@cisco.com>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
	<ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Thread-Topic: [PATCH] mm/madvise: preserve uprobe breakpoints across
 MADV_DONTNEED
Thread-Index: AQHc2ByyZsE/4mJZnUC+JXPldUxtUA==
Date: Thu, 30 Apr 2026 19:25:58 +0000
Message-ID: <afOsxsC6MKhkuqKD@goliath>
References: <20260429131522.4049054-1-dtominac@cisco.com>
 <889e4186-9f75-45d3-bd9a-1c90b218a635@kernel.org>
 <afIiqR5CqYRId0N0@redhat.com> <afJz3l6435DHLorn@goliath>
 <CAG48ez0mwkHz=4+PoLv_VmYrQiPqkSQqCSo=3R-ztrQ2zAHUwQ@mail.gmail.com>
In-Reply-To:
 <CAG48ez0mwkHz=4+PoLv_VmYrQiPqkSQqCSo=3R-ztrQ2zAHUwQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|SJ0PR11MB5199:EE_
x-ms-office365-filtering-correlation-id: 79f59276-4fc6-41b3-16d0-08dea6ee4f04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info:
 JOgewtNN5WPq8hyx/5cjOo56zI9CGIiUVVrZX7s/7/MhvBi0FKAFHb3OZ/A6vQqqXGTIbn75N9bFthN6xUbz5XOOJerzG43GVPVrj6xms/bJd9vdhz9FU2qi94KRfVW6l17XpF83BZC+9TpwAqymRFT5vlP/0zDHsE2TL539dDTfhXDftM3/FKZPAeC5NPdKvXinH5CPyPKkGQEzYsjDSOuXP8/9TSSqoKMsfX455/HerG6KHFlckykErKyTtrXIIZWORh3Y+9ZiIkP9OstcmFzENqoujo8BGmA5RVD/GosJOxaViLv38qWs7bdTTjvDmA5dc1SpOudznroE98pKHPlW9G+k7mQja/J1V4Rrjhi3W0LnZAFF4/UyUZ/vBist9LY3NQJ9H52sQnyz/UgYUi8UfjX8m/WyVaon2e+/0sbTGEP1nFKxqBOAG3vjrss8H1d6+HoIjsOIE1LJwsFHheiObrjMgAdd7C8G7/6BC3CfsSgFhHRi53cTm47TBro/zEegnKp/4qBMt0zegfsODnobhYTYCrm4d2IGIrclUU2EpZqEbNjuuYmkz7XkM/PM+xxjFBtKAal2ZrxhG5WXwks9v1RQL9t3eL1Ncys/nVCpS6xwVHadkFsk3mFrF2FUNBH+gLQHnjXa+dwUHta/9dnBSx8D+xHloVkxw6mNJEdhdYQUSmtEIaFDzSfExT5TX+E/q71eWdmunb2yU1cmuTDuyRfjqzdsizNh3Aelzv4e75fCfCVJXrv8k9RYOvlE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXZlYmp6N2szK1ZwUzMyMFFwRWE5NXhRSnpuVHhHeEhIZ0V2TzN5N3Q4SHFy?=
 =?utf-8?B?TVY0MnRNWlJPNHNLQjJrVUN3SVBlbmpoeEUrYUJDR0NkR011TjduN1VKN2RY?=
 =?utf-8?B?TW16T3JMUE0vL2dscGZsZHhwMzdSUlZYWmwvVVhBK2U4R3VxZ1BxYzExbzJz?=
 =?utf-8?B?dkZ5WlBOdGF0NzR6TFZmRGZEMEhPdHlmekJRWDE2bUlrc2dSYWw1akdKRWdF?=
 =?utf-8?B?TFh6ZmxoaTVWaHUxemorYnh6MnJzV05IbjNPc05ublRjSWJLTHJpUFhRUHN5?=
 =?utf-8?B?SHkvL2NTSElsTFZpR1I5YjhNTXVvdGFQVU85RnpqU3dvRXRkcDEvY2l0bG01?=
 =?utf-8?B?STFwQUhqSFd4MHEvaC9POUxkbWN1VFFJTExTSThDQ3k3bit1Mm9DT0RISnc4?=
 =?utf-8?B?ZTZCa01XVHA3WUJ5Q3V6VUYvVExiYUZVMkdHVld0NDlLZDFnclZ2U2FBaUhj?=
 =?utf-8?B?L2hKMVRnOC82MXlmclM5NGJzdG40NmNtRk1zOVZzRStqYWN6VDN2UU5aelpn?=
 =?utf-8?B?b0U4TDcySm1DaHlPUUJONGVKMk5ycFB0Qy8zeWd6V2p0c2tWOGU2RjAyOW5K?=
 =?utf-8?B?Tzd5TVFBa2N6bTV1OWgzUWpJZFhrckE2SmpwNkh4NFZsZ0cvM3pYRlZxWjly?=
 =?utf-8?B?UklSKzRQUTRTeElZb3VOQW5FNVcvYWpZcEV4NVF5WDNoamtuaCtOQ2hTN2Rj?=
 =?utf-8?B?dnkvVmpERXEvWkE4RVhNQmQwQm5wZ2s3T2pCQTRnVzdrNEtBVUo5SndwTnRK?=
 =?utf-8?B?TlN5cy9VMHNyOXBKSWZ3SlVDcmZ0R212aHcySmlwM2VsdzEzVmdXdmZYdjFa?=
 =?utf-8?B?SzQ4ZWJlK2pxa1IvREtVN2l3a0daV3gza3JPK3drVEF0ZWNkeXQ0MWNTZXRS?=
 =?utf-8?B?NzJkYllBZktxSmNDR1hDeFJxOW5RbXk0OE12UFp3Q2gvc3lWdlFac3F1NUdr?=
 =?utf-8?B?WWVQKzRZR3pNaytSMHd6OHIreEtmSkowZ0lnRjZaU0w1bXZ6bFU3VTRwQnFp?=
 =?utf-8?B?YmoxWFZvOFF5Q1NEMzRab2NXTCszRDQ3d3hINFNaWm9hTGtpb1lKMll1K3Ew?=
 =?utf-8?B?N0NvK0Z4UHl3TXh6bG5XUy8vVHdPenFMVHUzMnFHbDEyZ21JazFzM083SHE5?=
 =?utf-8?B?R2VUQi9aZ0w1aGdLSU5IM0VIL2FvbVZWU2dRaEQwd3p0MFZFZE5WMEh2TG1F?=
 =?utf-8?B?SnhBazhSbVdqR2VoclN0Yi96OVhzcFJhNHlrU21uTkZXRFM0WVc5bTQ1Mkph?=
 =?utf-8?B?OGZBdHkyOE9pK1FUdGJHd3ZsY1lmQ1IwTXVRaXEwaTFwTlhKd3BFWStEQVov?=
 =?utf-8?B?ajM2YlU1bjd4RWZKT29ZL25sdmJuSUpoY1BIRGhKYzUrYXhoNmNlUFc5RFBT?=
 =?utf-8?B?NTdpZlk0cjlMTDhrM3ZsZm9KWlUwMzRBdDJvVTJLN050YnpQZ3pIaUcwS2Zs?=
 =?utf-8?B?SHorZjVCc0l4bUdQNGpqcFNFZ2QraFprSTdzN3JXNGRJVlc5VVpXa1NXRTFR?=
 =?utf-8?B?Nms0c2VPSlA4R3pUdmp2KzNFTUsrT2lQQmxwQ1BOQkFQSzUxc3VBYWVQZmVx?=
 =?utf-8?B?UCt4ZndCeHdwOHNkaXpZNlRNOGJadDh3M0xTUHlzWWRCZ2hTcXAzQndIbGdp?=
 =?utf-8?B?Rld5WVRESXJ3OElEZTh1dGl4MitPZ2dFOVdrY0NTOE1waUZ5MWxQWmsvc0pt?=
 =?utf-8?B?RlRlMGFJaitTRFVWTmM4THdhZU5WRGNvb1dtS1FFQkQrZGpHbHViNGp4N2Iz?=
 =?utf-8?B?dkRZQjFEUWNJM2NBWHlLQ1Z6T1lXTmxNaHdBZ1ZpbFNENFlSS1grYWtiUkta?=
 =?utf-8?B?K3dmc0hHRytaeTQyRzRPV3U4M00wUmtpVk1zdjd5VSs0NElXT3I3OHpONEVG?=
 =?utf-8?B?a0MvSGloSlhiaS9FZ3ZGNzh2QmFIQVg0L2x1OGtwbVQvSWVUT2tXZGZxS1JK?=
 =?utf-8?B?dTRtU2lrZzMyT0ZaMFZ1MGltYy90RlFMcEwxWDBteTBBK0l2ZU82dHB4NEtC?=
 =?utf-8?B?d0ZYNGpMYWxDWmFGUVpFa0hsNDcxZ2JkUWFlNS94aHF2eWU1aDNsZDlmcmI2?=
 =?utf-8?B?azlsK255SE05eC9INzJ4TFF2b1BOTTJUeHZjR24yellvdnRwcEhLdUwzdkFi?=
 =?utf-8?B?cTBMRk1ZTXdnb2RLSFAwbDN0US8yWDU5bjc5cWd0N3plWU1RcWdGSHlIdU1I?=
 =?utf-8?B?bncyZEZKeHluUmRhZ2t6RnZOdFFxZ2JMRWk2WkhxYjBCeWFadzk1UEtreHhn?=
 =?utf-8?B?d2QrQUtpMG8yOW1zMnVuajVKUlJLb2t4UXBEMDlMTjcwNkI3Smk3eGNjOEI3?=
 =?utf-8?B?dkY5VUhhT3dob2VzTTRIcnEzQlVwVDlXTWdjWGdEM3JSOXBNa3dPQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2DE3CE4DEE6BD47A8B85467DC713DEA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mfoo1DEhVrTVbLa+ACa0m6hJr1yoF22dEnYXrhV2K4PziuhjvplFIOUFKk+4HHu4GGpvmB/QKk7h5xgqmN1oCkn/QPrZH+POmj+WyilcGD75JOtB1/T/qf8oP7C5OFrjGwukeMbg4++4ikfQYB5pYAFRwC7Gk3fRKYxhapeFnAbu0lPnN+4ng8j7upLUGuMyROFgv3jkIL85n2DTlS6Qkl5RBqHQbXI8ZGd9MSTooRxy0oKbfLBlN2MhvkBQ73urnX2WARLNWE37dDRGvD4ZVac2Uq3j7tEJP7aPTSgdDGIT5UkzJkwoNEFtgn1rjMLeoTTLn8ga5LG7E2SScxb70w==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f59276-4fc6-41b3-16d0-08dea6ee4f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 19:25:59.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JaEDY0YgcLewGPmDAudzlmAyd9JLQnY/qzyLbqrOAA8NHIW5GjU6wcJfh0uQF53wmwuEBNJfUAI019I30T674A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-Outbound-Client-TLS: ANONYMOUS;rcdn-opgw-2.cisco.com [72.163.7.163];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: aer-l-core-12.cisco.com

T24gVGh1LCBBcHIgMzAsIDIwMjYgYXQgMDU6MjI6MThQTSArMDIwMCwgSmFubiBIb3JuIHdyb3Rl
Og0KPiBPbiBXZWQsIEFwciAyOSwgMjAyNiBhdCAxMToxMeKAr1BNIERhbmllbCBXYWxrZXIgKGRh
bmllbHdhKQ0KPiA8ZGFuaWVsd2FAY2lzY28uY29tPiB3cm90ZToNCj4gPiBPbiBXZWQsIEFwciAy
OSwgMjAyNiBhdCAwNToyNDoyNVBNICswMjAwLCBPbGVnIE5lc3Rlcm92IHdyb3RlOg0KPiA+ID4g
T24gMDQvMjksIERhdmlkIEhpbGRlbmJyYW5kIChBcm0pIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiBPbiA0LzI5LzI2IDE1OjE1LCBEYXJrbyBUb21pbmFjIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4g
PiA+IHVwcm9iZSBpbmZyYXN0cnVjdHVyZSBkb2VzIG5vdCByZS1pbnN0cnVtZW50IHBhZ2VzIG9u
IGluZGl2aWR1YWwgcGFnZQ0KPiA+ID4gPiA+IGZhdWx0cyAodXByb2JlX21tYXAoKSBpcyBvbmx5
IGNhbGxlZCBkdXJpbmcgVk1BIGNyZWF0aW9uLCBub3Qgb24NCj4gPiA+ID4gPiBwYWdlLWluKSwg
dGhlIGJyZWFrcG9pbnRzIGFyZSBzaWxlbnRseSBsb3N0IG9uY2UgdGhlIGRpc2NhcmRlZCBwYWdl
cyBhcmUNCj4gPiA+ID4gPiByZS1yZWFkIGZyb20gdGhlIGJhY2tpbmcgZmlsZS4gIFRoZSBwcm9i
ZXMgc3RvcCBmaXJpbmcgd2l0aCBubyBlcnJvcg0KPiA+ID4gPiA+IGluZGljYXRpb24sIGFuZCB0
aGUgb25seSByZWNvdmVyeSBpcyB0byB1bnJlZ2lzdGVyIGFuZCByZS1yZWdpc3RlciB0aGUNCj4g
PiA+ID4gPiBhZmZlY3RlZCB1cHJvYmVzLg0KPiA+ID4gPg0KPiA+ID4gPiBSaWdodC4gRG9uJ3Qg
TUFEVl9ET05UTkVFRCB1cHJvYmVzLCBqdXN0IGxpa2UgeW91IGFyZSBub3Qgc3VwcG9zZWQgdG8N
Cj4gPiA+ID4gTUFEVl9ET05UTkVFRCBkZWJ1Z2dlciBicmVha3BvaW50cy9zZXQgZGF0YSBldGMu
IDopDQo+ID4gPg0KPiA+ID4gQWdyZWVkLCB0aGFua3MuDQo+ID4NCj4gPg0KPiA+IFNob3VsZG4n
dCB0aGVyZSBiZSBzb21lIHNvcnQgb2YgY29tcGVuc2F0aW9uIG9yIG5vdGlmaWNhdGlvbiBmb3Ig
dGhpcywgb3IgaXMgZWFjaCBwZXJzb24gdGhhdA0KPiA+IGhpdHMgdGhpcyBzdXBwb3NlIHRvIGp1
c3Qgc2NyYXRjaCB0aGVpciBoZWFkIGFuZCBzZW5kIGEgcGF0Y2ggdGhhdCdzIHJlamVjdGVkPw0K
PiANCj4gSSBndWVzcyB3ZSBjb3VsZCBhZGQgYSBwcl93YXJuX29uY2UoKSB0aGF0IHdhcm5zIHdo
ZW4NCj4gbWFkdmlzZShNQURWX0RPTlRORUVEKSBpcyBjYWxsZWQgb24gYSByZWFkK2V4ZWN1dGUg
ZmlsZSBtYXBwaW5nLA0KPiBhbmQvb3IgKGFzIERhdmlkIHNhaWQpIGFkZCBhbiBleHBsaWNpdCBu
b3RlIGluIHRoZSBtYWR2aXNlKCkgbWFucGFnZQ0KPiBhYm91dCBob3cgdGhhdCBjYW4gaW50ZXJm
ZXJlIHdpdGggc29mdHdhcmUgYnJlYWtwb2ludHMgYW5kIHVwcm9iZXM/DQoNCkl0IGRvZXMgZmVl
bCBsaWtlIGl0J3MgdGhlIGRlYnVnZ2VycyBwcm9ibGVtLiBUaGUgYXBwbGljYXRpb24gZG9lc24n
dCBrbm93IGl0J3MNCmdldHRpbmcgZGVidWdnZWQuIFNvIHRoZSBhcHBsaWNhdGlvbiBkb2VzIHdo
YXRldmVyIGl0IGRvZXMuIElmIEdEQiBpcyBkZWJ1Z2dpbmcNCmFuIGFwcGxpY2F0aW9uIGl0IHNo
b3VsZCBhc3N1bWUgdGhlcmUncyBhIHByb2JsZW1hdGljIG1hZHZpc2UoKSBjYWxsIHdoaWNoIHdp
bGwNCmh1cnQvc3RvcCB0aGUgZGVidWdnaW5nIGZyb20gaGFwcGVuaW5nLiBJdCBzaG91bGQgZW5k
ZWF2b3IgdG8gcHJldmVudCB0aGF0DQpmcm9tIGhhcHBlbmluZy4gVGhlcmUgYXJlIG9wdGlvbnMg
aW4gdXNlcnNwYWNlIHRvIHByZXZlbnQgaXQgZnJvbSBoYXBwZW5pbmcuIEknbQ0Kc3VyZSBtYWR2
aXNlKCkgaXMgbm90IHRoZSBvbmx5IHRoaW5nIEdEQiBoYXMgdG8gd29ycnkgYWJvdXQgdy5yLnQu
IHNjcmV3aW5nIHVwDQp0aGUgZGVidWdnaW5nLg0KDQpOb3RpbmcgaXQgaW4gdGhlIG1hbiBwYWdl
IHNlZW1zIHJlYXNvbmFibGUuDQoNCkRhbmllbA==
