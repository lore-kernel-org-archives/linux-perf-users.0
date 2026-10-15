Received: from smarthost2.eviden.com (smarthost2.eviden.com [80.78.11.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F94EBAE1;
	Thu, 15 Oct 2026 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055035; cv=fail; b=lb8cFYaCo7pVZWRFjfmaXk2bjpvM3m4JtqAQ5YQi5PPeYnWXTkHmCKGLUaR/nVfwh3xWOnXqwO4M8m962zaRoGtpPh0ROMGS+VDMHzyzQJKpijMt0H5hwUznXNAZC/2NSnjrSHksTDvui8QeXMFCAzYo22gIFaz7NRuuG3hrrFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055035; c=relaxed/simple;
	bh=k1GB303ASba+PRdWuVAdKLhCbX0ugAvAr9iEd7TDUds=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OfTMnVoFu4J5vT7kARU5POd3JYYAXzywkAaZjLj8VSOX9ALMHxIjP8UwAX1W0FP0JJZxAoKjaW86d/tU6NcoLy37g75zk6a0XkWC/MJYDm63ZoskxjEcjAySkcjHUytmqbkRiiD/9ChvWN8fHOVM2+pc/u96SWvgNncuRLx4SgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com; spf=pass smtp.mailfrom=bull.com; dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b=jDafTJyi; arc=fail smtp.client-ip=80.78.11.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bull.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bull.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bull.com header.i=@bull.com header.b="jDafTJyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=bull.com; i=@bull.com; q=dns/txt; s=mail;
  t=1792055032; x=1823591032;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=k1GB303ASba+PRdWuVAdKLhCbX0ugAvAr9iEd7TDUds=;
  b=jDafTJyiZECeDJ8zkc2aosiUHW0iDwKxZxS5gR4dG8WgbKWdGhukSyy4
   +Zq30LuWClpPD8qlacYBnIp/pGO4jnssOuXbxt3lSsuL7iQVsSQDIAHqm
   Evx/LSzWznJqPBd5wzG2e+79X2OkSJO3jA0Uw4LZxjKhCPwPOAf60S2hC
   n/9PuG4P0uQNY55mHD9L5uTTMuI5edSoPlJ3ws7RS5WoLRO0y1ETAPJqN
   YyeMsCLwp0giZyA/1w/uLonn1QckfFsupP8732QnJEM9pccpM/bNRSRrI
   9YTVJblx1WzQSokI6SCnEVcHrHcxY1Pt1zFj+/y/LcnBe9J81iCLQD6IM
   Q==;
X-CSE-ConnectionGUID: h4LO0lsJQfyd5wZkqzGbUQ==
X-CSE-MsgGUID: joz8bRJFTPO8FqOObqrr6w==
IronPort-SDR: 6ad096f2_4/tpcDugUiEDmyweEoKTybnQ14xCyXvIQWgZsWiz16t9cWC
 8uwhG1W0bIbXv1tQTpEK7Tn9NlUtOKhyp8Q2EVw==
X-IronPort-AV: E=Sophos;i="6.27,159,1787004000"; 
   d="scan'208";a="48951876"
X-MGA-submission: =?us-ascii?q?MDHEhf/HQyLjPS5iBX8eEpQmcIChimJp9dbP+A?=
 =?us-ascii?q?YoFr0m02rKN/i/4sPmRUrBP02UI4FJEwITsB+I1N12HaTot1V+queTnX?=
 =?us-ascii?q?hk4dTFyx+WGpdiV4Q4PsTPAJ3MhYUY6fnkt1Cszg9aTfo5VhzdSRa+EE?=
 =?us-ascii?q?Rn2fBd+luSovMTPRSrgjAF8Q=3D=3D?=
Received: from mail-westeuropeazon11013027.outbound.protection.outlook.com (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.27])
  by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Oct 2026 11:03:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+mUKW6H60V1HL2zTyLVIGzxkp6vjXYOmM1HjhywXMq+DiOUarrluGAiFFOr4J2toTuFi7dwo+IhWgwCxSdFKN20qkFcoXVqpD2jTqV44Ck0NtEYJDLHU/nYsCr4SGF0QCtjYA45mvoS081lEN1xdnb7/KGF/iceibsXgCLTgARi2i7E9eHbid7bWXjaN6lsmPf2Mv66sRBWKPcIMStD4TAJwS7KCCr9Qf+B8/zkdqWGbDukn7fKqr8oXD5Knw2YQPDKM3k9LewjLKP5umeeGCSk3D4ZiXr6IQxQKgoBRV0+yfe4PgNIl2eTqJ8wUojop6iopl0ZQybD4TsqPzBbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdlYmtsJ3S3fIgt9MBoy7145Vyle67uZ6Wgs6T0uK6g=;
 b=WhgCDZp7qUFVjHtOwUJgf6qKmSnpKEZr3Etz+LmI67mRv+r78vp+Tc9X/7B5QhvO9qBMaP7LH5TVsMbSulJbrMBAxrcpWmGm+WC+unP56x0ZLmz0zPI9a9YmjIzVRwQwWZYlZQIkNjCMyUiHmb44cKyqu6eAwubifPOXVK1sytJfMn2OdxBaShw7CQn5axoannsNH/zFxeUs4XS7kY2Bhhy4rUVst7OGSznXZIiKUQCHMXvkCcYX1WTZ4CefVCzhp79Z4vPz7uU9qHRuCQTUdyF/v9DT97WbHjm9MpMjQqxrgWLHcRyL5KkxH+7InBvn5HF9quU1uh4FzUNYIACVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from PR3PR07MB6922.eurprd07.prod.outlook.com (2603:10a6:102:7e::12)
 by DB9PR07MB10076.eurprd07.prod.outlook.com (2603:10a6:10:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 09:03:42 +0000
Received: from PR3PR07MB6922.eurprd07.prod.outlook.com
 ([fe80::5fc9:82a2:51f0:97af]) by PR3PR07MB6922.eurprd07.prod.outlook.com
 ([fe80::5fc9:82a2:51f0:97af%3]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:03:42 +0000
From: Antoine HURET <antoine.huret@bull.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [REGRESSION] perf: Rewrite core context handling breaks multiplexed
 cgroup events
Thread-Topic: [REGRESSION] perf: Rewrite core context handling breaks
 multiplexed cgroup events
Thread-Index: AQHdXIPxt9V+Q2OG/EWPpW1q1Q1eEQ==
Date: Thu, 15 Oct 2026 09:03:42 +0000
Message-ID:
 <PR3PR07MB69223331EED5BEBE150375B7849C2@PR3PR07MB6922.eurprd07.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_Enabled=True;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_SetDate=2026-10-15T09:03:41.940Z;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_Name=Public;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_ContentBits=1;MSIP_Label_466e186e-3e81-4e19-be45-56f1a3cf32db_Method=Privileged;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR07MB6922:EE_|DB9PR07MB10076:EE_
x-ms-office365-filtering-correlation-id: 64c04b98-2850-4c98-6091-08df2a9b35d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|260925021311599003|260925021911599003|18002099003|260925022911599003|10067099003|3023799007|11063799006|261009223027099003|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info:
 TtUG8S1UnuV7EBmLVWcVPySsNHaftyO5flzZHSTYWvAbyIGUGy2yMR2epJXK71aOn+HVXO8zVo2XNZATHZyiqghg5btFphHmYp7pEyblj9gBoZCQE8g/fa5JJTNdXO3BNewpkUxsOMYw7DgxcvVAvI8u7wd8XPYCDCfylJP0Pb9NN7BAt2LldxWHF0Af9NCLPmfaTKnonlGfe+LS8obybz2KmetuM51IPwtbQ3uLC2qn4tM1EZvebCcR/j58ER3cCvwaMLgcthGKlpxKJkxse6/t53TMotwxNyqx0329S8ClA569Tecas+ZYQwNkvkVO/nfm/Vm4l8f8/6uQOMEU1BLVL7thtm1SQrLy/i+3Z6VxNilL4U/MjZMYy06ZaNEuxpNQtWhC7rcu8Rbo3AFt72CzVmfqCm366TLjlbXVqV0jJoamdoTNifXsTNk4IuYT+12limb3roQHgkB4ILoh8pPCQG1RpK1Gd/OHX2FqyjD/qXPLzoVi+1ST/KpMOzF9WnigZAZ8MS2RaA7SZhB4F4FTt3SOm82ljnYOBYqmPkAGvJrgHG4hZTg4Qw0e80Ch0ZIVta7Y7/ha6+eHh2Qoyi6K1/ALUVoaEprtvcX37WVnLT88oGApPGqH3PwPLaklX2ZISFM9wnDtqPx+99UPVyDVvgy6aLwLyfyzLKIIKMyOkjzukbUT8IAx2PEjP2RZ5dgtlGuPtFR72KIGLAMV5ttkQZfU//B0ymjDxuxZqjs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR07MB6922.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(260925021311599003)(260925021911599003)(18002099003)(260925022911599003)(10067099003)(3023799007)(11063799006)(261009223027099003)(5023799004)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WRE7oJzL/g7w9rQklsLYZBXfO266sCukSVRyscx89QfMtgFnbGEVkWQGqH?=
 =?iso-8859-1?Q?Jncn3RCBoc1fOiw8Ld6Qr+450SvwstZxm5C+APH7sulxnatY6QpdGzZ3p2?=
 =?iso-8859-1?Q?OkVG6f3zGymxJj/05sMlXxOGKjzOH96Ltm8kmVdM9d09CGP1zZRSe7hpOs?=
 =?iso-8859-1?Q?LBIQ0XBENZ28o3WSjZk1/DuoyNbx6d8Dow5+KnuRrSJJneHRW0Sua9To0+?=
 =?iso-8859-1?Q?qbwgLece/CC0A7PuDZbFzzQNojj5PYaukCicDgE3FvI/CicW5Db0TbHrl4?=
 =?iso-8859-1?Q?3e9vkSGOghMEJXRrjsKNr4Gbi/1KKMmtUCQk0l3PnUbjpJqU3cTCmXybZZ?=
 =?iso-8859-1?Q?s1dSNK62XAVZFOopq2L8ZzJxVIBEURoKXfY8mmh4eaoPyh7mYi7Nivuq0d?=
 =?iso-8859-1?Q?NoXZZsd2pZ9ptY6J0eHP3cZh+0FNX8FH8Xtp9WMyHHgy0Dbth7IqIFtw8W?=
 =?iso-8859-1?Q?LICATx+bSo62YJhNWhu68/RlNTZa4cOPK9fNVTGMju7wmai7nbXx/l4kgc?=
 =?iso-8859-1?Q?GNX0PePUrLkNcIXVxU4xDFWblT+Ra/ETk27qIXRmKzTRMnk3ISwmmzQzBp?=
 =?iso-8859-1?Q?Pl/ZAJrjX/oPXUtl8DjogtfLPdzkTXXKH2e1F61a0stAvc3lD6NH8kViOA?=
 =?iso-8859-1?Q?yoagg4XjNFcQb8ii+wvzDM3B5dAED4Fsm0jHF7gyw2fgU2cmA+u3C5gaND?=
 =?iso-8859-1?Q?qMYFgzMR+rVT1d2V39NgEFrfviRjRbBhvkbP6zet6qXM+1ifu40dzoaj29?=
 =?iso-8859-1?Q?KP8oWYCfy7ZjSyfmCEPlPVq74PCN5I8hUpmmSxJZXXzX4eG16+GpKgH8TM?=
 =?iso-8859-1?Q?2ioS4n7Wd6R6vowAjPqwG5BLqQ+Vijx8i2cfBHBEfwW9DioCswTMEdZWDd?=
 =?iso-8859-1?Q?u9/2GXJzuS/cMyFthqNh6aR1dS+JNoUFz+RNsksGeHb7j7uwECpZ5Y5b+u?=
 =?iso-8859-1?Q?3+v66De0/QE521gBzCVN3l8gXvpf+SqPpMDrZ9Rwwo6rW5aHcHFgMEiPy4?=
 =?iso-8859-1?Q?WgYL3MY+lKdLBbRzwrXvQ+EW14/UFyrOAMpmnPn95y9snVhfLnVELYFm3M?=
 =?iso-8859-1?Q?qeYvSchysYic72Crccv85Es7RsP+2HMZppwSkwIRtcXX2RG52QpNpikAQR?=
 =?iso-8859-1?Q?j8dn+JliTsHCeEe4qgkoNkqcu+bOIYcRZPEK04Bi0r6Wu3TTfhSbEcrYPs?=
 =?iso-8859-1?Q?7ek1OE/+3VYD6ORhwRt986LqaRqv1/6IaYodRFcC8H3RP3NZY4gRR9Z3Iw?=
 =?iso-8859-1?Q?D5lxOFRNkhryS0EYArLSgj+43C8s9ip2u2NAafUf0S5Lha46SQHN+yhGjW?=
 =?iso-8859-1?Q?He+b70YX9k+g6yoSqtjVNqFZp29CTEEpQeQ7DMFg9Lsx+sfgF4X0NAfcED?=
 =?iso-8859-1?Q?PRhovMScPJWbGS5X/ng4/7qgg57b9lwiHlkYn59kSv7vnxGY4GEY4rhh9x?=
 =?iso-8859-1?Q?dZEICAvTRb9AMW72JzM4KbFfwLrw9txSpapM04Yiz3LscIK0n5ukQY/SRf?=
 =?iso-8859-1?Q?7DzqCv930UUr0fuEWHLJ+5ENW/czPfwlMxgss41vaM6/YgcAPiutHOJLDH?=
 =?iso-8859-1?Q?bBS7SlsvOD4j+JPwddrlYz28iHnkCJlH4OJHQG+aEVZjZZlgmVH0YeG0rb?=
 =?iso-8859-1?Q?LLVx/0h9ss6dny2xWphyG1XSeN2HtKe7Cn3a+tMOfq0J9EbaacE27Suicr?=
 =?iso-8859-1?Q?3PjZf+si7sjZPQDUqy9xTzqqskGLFRzpLSGPMjbKgAPZeBWbrGtmdnkSkQ?=
 =?iso-8859-1?Q?4h8iQXIb9NVxkxoFwLjp0c9/O4TW/zJkgL1Q9rkP0N5g48?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UdP8IsDk7eKmzD2jScTjvYIibk+Ozv25S/ZmWLjS6G70i+XPd5WgFzoqc+ShUHonez1NKwkN+KNmArTpmvC4NUC/vBUUfh5L+DC7xB5EtKFxgcDxiZOPG7AZ5kF2PcXHH5O91N1NSwRcbMXtEG3K4YDfnmsCdvhsf9arOl1qmfmRlSuZcNzDBd0FEZLFWIt9tgctpg5xIr8kWHDe/wv2d+8fM85KoJfMij5Jotf6UetT5q6GLvsJXOVIz+mluJsJ6VcHniEbDMDbjvFqPiNXGRhiGiJcMSUwWGeKUo27cu7KDnmGjJJC0IM7CVbrCGbWcywaFHHFmHeiaJLNr/MskA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR07MB6922.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c04b98-2850-4c98-6091-08df2a9b35d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:03:42.1236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnOUcdqwMkGbY1vaaTY4/uKJ8l6X/+Xwk+8BS16lSPFqB099C4K0ypK4mkrKXA0etkz0woVfcTQ/m1gbAugGJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10076

Hi,=0A=
=0A=
Since v6.2, cgroup events (perf_event_open() with PERF_FLAG_PID_CGROUP)=0A=
report a wrong time_running as soon as they are multiplexed. The raw=0A=
counts are fine, but the time_enabled / time_running ratio used to=0A=
scale them is not, so the scaled values are wrong: from a few percent=0A=
to several times the real value.=0A=
=0A=
It is a regression from commit bd2756811766 ("perf: Rewrite core=0A=
context handling"), see the analysis below. The culprit was found by=0A=
code inspection, then confirmed by testing it and its parent=0A=
(v6.1-rc2). The code is unchanged in v7.3-rc7, tip perf/core and=0A=
linux-next.=0A=
=0A=
All three conditions are needed:=0A=
  - cgroup events,=0A=
  - multiplexed (more events than hardware counters),=0A=
  - no cgroup switch on the CPU between two reads.=0A=
=0A=
The last one is the common case of a busy job alone on its CPUs (use=0A=
case: HPC jobs).=0A=
=0A=
=0A=
Reproducer=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Needs root (or kernel.perf_event_paranoid <=3D 0), docker and an idle=0A=
CPU (CPU 2 below).=0A=
=0A=
  # A busy loop pinned to CPU 2, in its own cgroup.=0A=
  docker run -d --rm --name burn --cpuset-cpus 2 busybox \=0A=
         sh -c 'while :; do :; done'=0A=
  # Process PID=0A=
  PID=3D$(docker inspect -f '{{.State.Pid}}' burn)=0A=
=0A=
  # Cgroup relative path=0A=
  CG=3D$(cut -d: -f3 /proc/$PID/cgroup); CG=3D${CG#/}=0A=
=0A=
  # 2 events to reproduce case without multiplexing=0A=
  EV2=3Dcycles,instructions=0A=
=0A=
  # 19 architectural events to reproduce case with multiplexing: the=0A=
  # repeated ones need more general-purpose counters than the PMU has.=0A=
  A=3Dbranches,branch-misses,cache-references,cache-misses=0A=
  EVMUX=3Dcycles,instructions,ref-cycles,$A,$A,$A,$A=0A=
=0A=
  Note: on a hybrid CPU, prefix every event with the core PMU=0A=
  (e.g. cpu_core/cycles/) and use a P-core.=0A=
=0A=
  From the host, run the following commands:=0A=
=0A=
  # 1. Per task, not multiplexed.=0A=
  perf stat -e $EV2 -p $PID -- sleep 1=0A=
=0A=
  # 2. cgroup, not multiplexed.=0A=
  perf stat -a -C 2 -e $EV2 --for-each-cgroup $CG -- sleep 1=0A=
=0A=
  # 3. Per task, multiplexed.=0A=
  perf stat -e $EVMUX -p $PID -- sleep 1=0A=
=0A=
  # 4. cgroup, multiplexed.=0A=
  perf stat -a -C 2 -e $EVMUX --for-each-cgroup $CG -- sleep 1=0A=
=0A=
  Focusing on the "cycles" counter is a good way to detect aberrant=0A=
  values as it shouldn't exceed the max frequency of the CPU, since the=0A=
  CPU is fully busy during the whole second of sleep.=0A=
=0A=
  Run each command several times. 1, 2 and 3 always give the same=0A=
  kind of value, never above the max frequency. 4 changes from one=0A=
  run to the next, from half to several times the max frequency, that is=0A=
  impossible.=0A=
=0A=
=0A=
Results=0A=
=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Intel Core Ultra 5 135U (Meteor Lake, P-cores up to 4.4 GHz), Ubuntu=0A=
24.04 userspace, vanilla kernels, not tainted. Cycles in 1 s, min - max=0A=
over 20 runs:=0A=
=0A=
                         v7.3-rc7               v7.3-rc7 + fix below=0A=
  1. task, EV2           4.390 - 4.401 G (OK)   4.390 - 4.398 G (OK)=0A=
  2. cgroup, EV2         4.392 - 4.404 G (OK)   4.393 - 4.404 G (OK)=0A=
  3. task, EVMUX         4.372 - 4.382 G (OK)   4.367 - 4.382 G (OK)=0A=
  4. cgroup, EVMUX       2.397 - 8.797 G (KO)   4.371 - 4.386 G (OK)=0A=
=0A=
The 20 runs of 4. on v7.3-rc7, in G:=0A=
=0A=
  8.797  3.986  7.248  4.288  5.851  4.487  5.794  3.180  5.828  4.083=0A=
  2.397  3.186  5.187  3.872  6.058  4.300  2.970  3.644  3.933  6.896=0A=
=0A=
Culprit check, case 4, same commands:=0A=
=0A=
  v6.1-rc2 (parent)      4.374 - 4.399 G  (OK)=0A=
  bd2756811766           2.094 - 40.427 G (KO)=0A=
=0A=
=0A=
Analysis=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
A cgroup event takes its times from a per-cpu cgroup clock.=0A=
That clock only moves forward when update_cgrp_time_from_cpuctx() or=0A=
update_cgrp_time_from_event() is called: on a cgroup switch, on a read=0A=
of an active event, and in ctx_sched_out().=0A=
=0A=
Up to v6.1, perf_rotate_context() went through ctx_sched_out(), which=0A=
updated the cgroup clock. Since bd2756811766, it only updates ctx->time=0A=
(update_context_time()) before __pmu_ctx_sched_out().=0A=
=0A=
So between two cgroup switches, the rotations see a frozen cgroup=0A=
clock. The events rotated out lose the running time they accumulated,=0A=
and the next update (usually the read) credits the whole interval to=0A=
the events that happen to be on the PMU at that moment.=0A=
=0A=
Supporting this: a task from another cgroup waking up every 0.5 ms on=0A=
the same CPU (each wake-up goes through perf_cgroup_switch()) makes=0A=
the values correct again.=0A=
=0A=
=0A=
Proposed fix=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
Update the cgroup clock in the rotation, as before v6.2:=0A=
=0A=
--- a/kernel/events/core.c=0A=
+++ b/kernel/events/core.c=0A=
@@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)=0A=
 	if (cpu_event) {=0A=
 		update_context_time(&cpuctx->ctx);=0A=
+		update_cgrp_time_from_cpuctx(cpuctx, false);=0A=
 		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);=0A=
 		rotate_ctx(&cpuctx->ctx, cpu_event);=0A=
 		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);=0A=
=0A=
Tested on v7.3-rc7 (results above). Also tested on the Ubuntu 6.8=0A=
kernel, where the values are correct for a parent cgroup, for two busy=0A=
cgroups sharing the CPU, and for idle or mostly sleeping cgroups.=0A=
=0A=
I am not a perf core expert. The root cause analysis and the fix were=0A=
done with the help of an AI assistant. I reproduced the bug, then=0A=
built and tested the fix on my machines. Corrections or a better fix=0A=
are welcome, and I am happy to test them. If this is the right fix, I=0A=
can send it as a proper patch.=0A=
=0A=
Assisted-by: Claude:claude-opus-5-5=0A=
=0A=
#regzbot introduced: bd2756811766=0A=
=0A=
Thanks,=0A=
Antoine Huret=0A=
