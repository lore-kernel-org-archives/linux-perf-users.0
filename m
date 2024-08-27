Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666818030;
	Tue, 27 Aug 2024 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727072; cv=fail; b=W2BkcC00ddwK1HUA0AdIHCqlFFoG+sRk2njN8dmvEjZU0avwuJRvxwErmGSUVpSPm8fSSbbsZC2KZg3UI1e1CjMVoCVQjn6jcFZLXG9dZIWNUlfIuw4aL0NFa07S9to7wi0KO6KPb1d7u8NS/i6DKk+uTvvJfUnxNruUHIuB42Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727072; c=relaxed/simple;
	bh=3mfPf9/7Dp5WRL93lfBD3GC/joa/6dj63C1lkTEhPUY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SzD65byDOhLP9AfjXtHXdpfTniYcz5frh0zRXimxF0dQdisCy6CdpMABVDkrXEOgyyPvIWAaX+yy6QZM/raCb5S5FdVmzaPDFTLWG3IzJROd27KpXXOaVjYNnCU1yNZ21rz+YiWtMKXw3+Zvue6+73bnneQXXMe7zd1Ysyly/so=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=NVoZyZJu; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=GPnjhqag; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="NVoZyZJu";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="GPnjhqag"
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QItGiH015318;
	Mon, 26 Aug 2024 19:50:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=+t0ZNCE6i3M8d
	Z7klEBCKD6tR9gdnUVLqC80JVBzZXk=; b=NVoZyZJuXTju8nF0G0PeEPc61HBMw
	UHM4ZtkWCtEuevWmD71ZQIxtNZTjSEiC1wSxJ0lGSn6v2eeUBBhNh/M6lyh8o5dk
	kcwWA+q+zpaRl9er2Oj8yxzDMm5d9PilaQayaCvDUntUIjieemkPJBUeN4f2PyeO
	1chi48hdRt4/+mNqNNxPIRDnUrYoEKwVkBpOnzkeYmkxRb4lR5gUFvJrG0/HhuWF
	vNJtuQcEdQos0JI/d9wbCrMWtSyXPLTEe7M1DfXM5PnIrKM1BGW0cZg+agx+wCCK
	8E2lD5xpvi7guMl0HdkOn0gMAzhyODmVlDO5VuC3x+QxXuXlYzhrYoBNw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 417bea4wtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 19:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoanXE1dQgbgWxV0rEutHCDYs8HuwPT6nZYP5xK1GyQgp07A05VxxWnQW6GqAZnwqJQQW568oAcfebt+nvIK4Ixa83YdLtHPqII94TRentaMjlcUJOkK+5Q0N0uQzlOCKDXWCRAq3/YTP3m5bcLoQ0+yEsud3thN07osENslqkDlIVjYjb1WUten4EHpDb1uXT5NA/tMXD4k5ABX4tXiIVnbJ9hjaX+jVTqlN5yfwslrLXlV4LiiuckSwzx4roUvpxyWUdZ26Z9OU+HEhWCr3hUlQScgxs3dhFCcOFkkh2Rq/CPx64BeJBcLi+KGLFnlU0FNySp8CYmUFaBXshE8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t0ZNCE6i3M8dZ7klEBCKD6tR9gdnUVLqC80JVBzZXk=;
 b=JMzTu+4F08K/OmqMxJBUSsM/7AJC1NUsKkHvIZ4BI/wuiS9M/JNARzaKCLP/vFshLvN31y7xjHPwAsBC3VXmgaT8gQfKD5Z58ZC4aL8XvgbeFHRH+mf6an6pD9K4u8m/hXQMIcFAShnv8FcsbKjnn345sYWR72TkezS1zP2zdFKQDUoElfP21XJwVQLzK1zWEKQxNEk8eVeMaOKenVto/THTJeRNUUp0T7EzJYABVBvVuNc6+zBrpsxm2PPiC0ZYnUDbYjYmTgXr8hEIbeaYMqeVebKfiCFV8HbAPpUtj4zx03qrndSVSDVPOe5pHdvf5J9lgaAHU7nCK0V2W1x08w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t0ZNCE6i3M8dZ7klEBCKD6tR9gdnUVLqC80JVBzZXk=;
 b=GPnjhqagMVZ/9YczNTGJOc81s3LZOh+U11BaMkZ2SCNrgSs+slbtMYrNyup0szXWTnrEnMwFARmOSxAjlNV/zgrkHSXYAZBZ5Pwm+Wf2c+6cq0wEF6O7726A+hNaap955sVwNjQqXsWloEZuTjkYZM41Wn1/v28JoWAeJLvR4ep/LmSM6swq227eC2UJwmyaWrlCcQOP1u5cWH9FpAWroFYqu2cBCUkbBMZWNe3KemzxPp+f114+/YKR12dOBxC9amP68Ybzdq7rfAa/2KURMS4iNwWCfZMrzXBC1rgAhHZCaB5y83YOgFTK6pMrL9NbYwP3lgDJBMzbxldstQy5mg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by CY5PR02MB8920.namprd02.prod.outlook.com (2603:10b6:930:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 02:50:49 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 02:50:49 +0000
From: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        eiichi.tsukata@nutanix.com, howardchu95@gmail.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built with -O0
Date: Tue, 27 Aug 2024 02:50:26 +0000
Message-Id: <20240827025026.157595-1-eiichi.tsukata@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To CH0PR02MB8041.namprd02.prod.outlook.com
 (2603:10b6:610:106::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR02MB8041:EE_|CY5PR02MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: ea19d9d8-46d8-44fc-6c6e-08dcc6430e8a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wsPoVU81MThZdmag5zSiOkE+/t7ITUYYun96sM/Fel+0lZkL65/ikosXo+ba?=
 =?us-ascii?Q?Jo2qdhSLXXIYTRunW+Hb/Ab5rXbr9/UfNPoAAf78OFAui3YFNKRzNCBQPCf4?=
 =?us-ascii?Q?kKtG+eIn8XV+lZUY3l50GNDyyLpFHA23+hRLjzVDZR2bt/3AumnWSaFfgKxR?=
 =?us-ascii?Q?FObWhsljwtDCdYNvyJbjxVvlwwPqmTASq9dKPRyWejUByqMD5K35KaMvoVlT?=
 =?us-ascii?Q?M6kY2FzjQIKOYQpEX2rGZw33S6xdgOsrQQF3C7oePFKipZusDnnCJK7m3WTO?=
 =?us-ascii?Q?SDZPeXrEbSOZktl9elmtk0aAO4/kE+A/kZQsFuHYQrnjWB9dC15Ys4NP02Ul?=
 =?us-ascii?Q?rkCvO2SG9DnkVaJgm/Un8S+C/AGOZWt/F/+FrwjMC+i28iTRYQsfau55wWjL?=
 =?us-ascii?Q?PB6iIv3JEea3K9hx724+TKCcxVfrLXkd6Aup4kWlK5LCOQJSTgZ2WpJalHNM?=
 =?us-ascii?Q?nhT/zxmSfxco9sVEw1WzLBaFfnViog5JIj6QWVLZsmTFTy0SVYTzByvzwuhw?=
 =?us-ascii?Q?ECpCpgUsBmVdFXjhcaxPbbgNX9hYgoGm1Lmwg095LHLq0BVVACxI5bFsgiGI?=
 =?us-ascii?Q?Xkmwf0Frhx7nVCUqWjukewXeCLBcLpRZbdUdJT1X50sX6kPIuwwo90lsdEAZ?=
 =?us-ascii?Q?XIiJgxojOc8TwldwEkaY7z4qrqg66VBHtUTvoqCWbxdC20AQSr8fo+lEemkf?=
 =?us-ascii?Q?2cu4dMuOwAgFo/LigaMXMf0i+uRuQHsXVOEa0d8Pr7HCI4DUm58B+49SefSG?=
 =?us-ascii?Q?Um8kRK1sIq5a4CKcw6H9E8+qLNeRyVitxRaWxeMKz1+z88J1NLCzt81z7yWz?=
 =?us-ascii?Q?o3oXBHM+EdK712tOwkDugF/rbie7ddsv3fJnNnGneZR35JlpkC7hb62Vf2S/?=
 =?us-ascii?Q?QN7NQHwViqR2LJNpvOorNtjF3eX0Cq2BSSaO9i1o7Yvat/Rvd00cB0Xh1C3f?=
 =?us-ascii?Q?cdG6gawfgCsz52Uy63LTq0J1VoXHjVIhlL3ocsDMm57D3ZvMOiEHvDhw+ZfI?=
 =?us-ascii?Q?PgTA+VDAFVO/C/6hemgeYUB2LIVNDVqMTD8ZKUK8F8BnNL16vaF6hOaHq90C?=
 =?us-ascii?Q?lHt1+NR74YnY5tC0B5zvXzQpIK6xYRW/ZOtkR1ezV5Av1TtPy84AXv4AnKod?=
 =?us-ascii?Q?q6sQEnx/Sr6+FgDvDWLR4KQyJ93JuwrrefniRKlRUXXuwmoAhSSt4svQ1Ruj?=
 =?us-ascii?Q?hxMRWBw7kE9zILT4QvQT2AtmDa3km62f8A5QBQl9rV64zq+CUlhvo35NP9ac?=
 =?us-ascii?Q?vv+4qTiq84s80ug6iUFyW2jfSuvhASy0SsDgybv3P5gafZJVX2/LJTMix4I1?=
 =?us-ascii?Q?NvBQbyqfw5g8+K4CWSNHkE3Kgls8abll8XJVpmrKJm8WoPJGhpC5njBl47T4?=
 =?us-ascii?Q?a1Gg98GLbC1HRS2VXoXnWbyaTV0jc8AIdj6lII+zSzDN6YhkT8r/1U+v078v?=
 =?us-ascii?Q?kziTGLbNMr0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PNv8FzAAFUb9BpC4PeG35MBO6ASzqaLkQN1XA5JINRCUJuWSibYjxMXmo4D?=
 =?us-ascii?Q?27FQtI+myVFKwWvlt6RbJblJpknL5MNPSjjDx+YUW881aGIdqeZKl1Lr8ovi?=
 =?us-ascii?Q?Xgjobc1u1bP2rWL8nTrVE7FQmielQpTtgPikCshbdUoqGWo8qCp5ruLHsdSe?=
 =?us-ascii?Q?1GdjgSfbIDbwZDR2CIcHPfNFkwSDkuWV9n8a1ZcpNApRsGaGzKK8b21JgQZh?=
 =?us-ascii?Q?NP7AcNdagBDXOOtwYQy62hi3FJC2dTKUWxGIQbU0+l+kuQPWVCNZdCIgaGd6?=
 =?us-ascii?Q?3+BFjRR9zX/S7fM5aSJ6DinuIPQpNPqNvSCSvnLLmpTqXg5nShqi/I2jgnPG?=
 =?us-ascii?Q?J9VRGOHDt0o7Vvj/jxVPxA7CsEFkzZZpdZe8Idn+elVpl0g6tBApgVhpPgF+?=
 =?us-ascii?Q?5J9qg9mfBku86nhdD9LsahbG3Tty3UKKPcbe2xnCRHOBOPrkmCi5FikJabHL?=
 =?us-ascii?Q?BLm86lfrusKkClQaQ3ZB1VoGQS+TyETyeniTQ8e4WOGUI24rwWyyBDVjgOCM?=
 =?us-ascii?Q?WXUEoNQK8Hpx9KSL11UK3QX7seKcoTZYVXZKcOic6pexoy5lvwpPsOLvhRfg?=
 =?us-ascii?Q?CDvtI7rWwbGF0zEjO4dwAeTLnM2kEZP4LI3nTmEapQLNJwiayPXdvdOI/iEF?=
 =?us-ascii?Q?Ph9vWFeN/U7SMdXhgVmQQ/UU6ME31XI0nMqLPYFHR4Y9MqSBQIjWCKKrhbw7?=
 =?us-ascii?Q?PquEaMjzNM2LcW+xHn6+Zq9E7zd6ZIe6BrYtPnK1x2hocaAlvumCeay+1bSn?=
 =?us-ascii?Q?KQ73IlwF3RcnqFLYrjpTyws9uZYd8uP55s0i64nNGVEonpYQvU8BrxoFoqrD?=
 =?us-ascii?Q?nMbVG7l8+mfsa5gOCTxaCoKsoXhOy9nYysr/sLvyBJI1PuY9/a1KZsWrJiYB?=
 =?us-ascii?Q?2J4d3CTzXA5t6SLPeatdwS5dE3lvGycxKhSbpF3IYc3Xq9fJyy3PBwYfIE82?=
 =?us-ascii?Q?XairMI2mmwhZcqn3ibDXA1A29Y+1UJ91bhlOMgPQjRyx0bTucqgMYXrKr/ap?=
 =?us-ascii?Q?mJTq8e8WIfrht9NOI8AnG2C6Wmla6BTdqEaK1+Vz4j7vPg+jV7bR8qtA0dJC?=
 =?us-ascii?Q?+WH/5Cb7Xu8z9E64jRpQ96UmXOAFJSawhlrKmpwNgmKqNiOhvxMGm/OITmEy?=
 =?us-ascii?Q?j8BoYgM2V7Eumbl48oVqt5i1luo0M7Q+q4i7SWYENgQTP2r+rgWV9MGONty4?=
 =?us-ascii?Q?Ca0rxVpuWMjotrUJ5aywlinWU5e1sLDZOrTRCLWY5KYX9bkOphWEvVwB/wk3?=
 =?us-ascii?Q?gmQqUvQWtz0jobxbzcjk6ChrGirPDCtxVjaCb4Pw/8uaqUnfcUVJPqljtp4w?=
 =?us-ascii?Q?5Hs27a28kjnvoXwKTpiENE6ralEPXS0ytZEHcPmQ47XF92AbkyM5HW9iSzzi?=
 =?us-ascii?Q?ECrFJ5Bg4uJwpNDg7dyj61ZV3TgULEITHKIyvja4S5sVju2bU7valUDkiiXX?=
 =?us-ascii?Q?KIQjFi0s7yFrrdcpwhIjqjaoK/gQzz9Zgo+hdLjr8ofdpohzR6kEZQj1XBcn?=
 =?us-ascii?Q?DRoVn0Pd4CFFxTIq2VWtJIbWdulLP0c1Y1cr8HFNCCALagDxUoD3+XyyNkei?=
 =?us-ascii?Q?mrP3AB8RU/hg1ZzpgC/z6SfK7XTGLlLsgSn9XDaqTGJr2GLkysjXzuqf6RML?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea19d9d8-46d8-44fc-6c6e-08dcc6430e8a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 02:50:49.0877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12A2Ois612hyU8uQkPAD2gXVllW7So8mVOSgot9cCDLs4xogJzYKAsIYoFFL92f54Z7DWjY7EkzktRZjnjDYM2T02xNkm3nDQXqU6PRaMqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8920
X-Proofpoint-GUID: NkrsjenO7B6YPuoqBGl4V58CZNW1VL4d
X-Authority-Analysis: v=2.4 cv=d4ynygjE c=1 sm=1 tr=0 ts=66cd3f0d cx=c_pps a=vIBLTX18KUGM0ea88UIWow==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yoJbH4e0A30A:10 a=0034W8JfsZAA:10 a=64Cc0HZtAAAA:8 a=fNzyBwpH0SV5MRlIClQA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: NkrsjenO7B6YPuoqBGl4V58CZNW1VL4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_01,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

If EXTRA_CFLAGS has "-Wp,-D_FORTIFY_SOURCE=2", the build fails with:

  error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]

Use "-Wp,-U_FORTIFY_SOURCE" instead of "-U_FORTIFY_SOURCE" for tests
built with -O0.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
---
 tools/perf/tests/workloads/Build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 5af17206f04d..e9af6b903770 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -8,7 +8,7 @@ perf-test-y += brstack.o
 perf-test-y += datasym.o
 perf-test-y += landlock.o
 
-CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
-CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
-CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
-CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
+CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -Wp,-U_FORTIFY_SOURCE
+CFLAGS_brstack.o          = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
+CFLAGS_datasym.o          = -g -O0 -fno-inline -Wp,-U_FORTIFY_SOURCE
-- 
2.46.0

