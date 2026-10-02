Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0F51589D;
	Fri,  2 Oct 2026 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965728; cv=fail; b=PfDCtxfkeJXNy9clWzCXsjDXwQbYotcYOJVO9nPIgws9QkMSxFB3Bh1f/bAjCYLxADTgic7w8tEoJmourMt00pPIVlNGZR6QLGKAWW0ynI1RG6U11osoixfAz7RQZ2UzzSkpFJuxibmTAJGLdjiFn87/kfvGNX3NRlsPBrvzM2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965728; c=relaxed/simple;
	bh=sRzGwQLT7uNWGk0lYQNg51SL++RLd0HcfdCpOouPHr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=qWLw+utQlFriK8HXy6h/kHgZqsJd3zqudSHWmowZzRh2wciN9qP5LzByRUOdd6KOI4UBPu5tz9VoUBAgO2VBoDNBJfbHZaH2f0i1M3xpsrjWjdhO/k43Vms8pdZBXpIZLZA8f0Rc78/qVCRm9rF6dd25VsyPDZVPbS5cmbHxJeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ei7J4Waz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U5keYFyN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ei7J4Waz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U5keYFyN"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692EbdJ0730159;
	Fri, 2 Oct 2026 18:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UQeufG8q3oaQzAaZV7HT2BSSalh5npBV9lZzs65PW0c=; b=
	Ei7J4Waz+z2+hHer5Sn10xpwXmJ7GV+dYM44F1TVxZkBXXo0N18Btn84bD9ZMS/d
	1093vs92zdvcYZ8STnPlZXxrVhd9mj53k16gsPe8ZPshz8cJrHPEwDCNoCaRnv3c
	UootMyW0mu8KXeqHzXWtjOipS+bmGCcsEKWtPXfiIge56/KdauFQop2xFTbE8hc/
	zZupbnWoMAMvlO2BQOu6sht+NJ+f3UtHWAN3v/h4i3sYaFrHL6r1l+2fP0ArH4jH
	RXaP/m6Sl7T/e3jLa+sM1Fw2bXMKITVe+KLwj1DsH4j+CIZ7/cVSNKL8wjmubbdN
	Qh6kURbAujr0QZeQYN3xZw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c4jka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 18:28:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692IK0vC038965;
	Fri, 2 Oct 2026 18:28:08 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gg2ryp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 02 Oct 2026 18:28:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxwCPASDZKmNG8PIzXO8EsdsMql0ZOx56X35unEK6LvgZUQ85yL6XxHe6B6oHBRlHzYK6aGDRZ4E0/XgGxBoR6Dcz6FTkcn0kt5aFVFObC+w3MrM2yRpWe10lpeVQiFwZoixZi68gu0s9Hs17/lw+XP/t7d//rlEMLx0lGwHVLdNtTWxxjNouEfOdXwmOgTHBCt9AOkupypNH2E+6qXJGTn6U2Nr+4L18VzQP+2koNKc62rgLokqzw4qFh4u//rXXhMH9mTT9JH77XoTvSOaJZZF+tE9gV0MCgFO8bN9iDTdoXwGVTpgm6QXhGttHHllF0jSyUwxyYnOMwJYHyS9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQeufG8q3oaQzAaZV7HT2BSSalh5npBV9lZzs65PW0c=;
 b=NA2DlV4wVI/PdjE/Kl6l9L9VvT9lkIB9aKvrETHOz3MTCYsH+cAfsXu4zGc+rzkFmRf9Q/oC8yObADpnAais+fqu9JEnrSktYxgc+KV/ic6PQY9vZqAxYbKupTP8PeXcOqcdhT/cB/jJ6ose9aF+o9B0wNmBn2iBluddFhxSRH5z0De2Jr7STgKkG5FPA/7lHhgcAgODDRddezPX6wjIb7yuZgW4N/wpFKgQ6n8Auk3hGel+SybCIRNqrIrUYifYWfsoYeT219+9AaRyoATRO3D/ctuGEhTvI9+AmvoQmQNZczsuWdK7kSeAwofJdxGHfssNyvYinnfrYI2xs6YZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQeufG8q3oaQzAaZV7HT2BSSalh5npBV9lZzs65PW0c=;
 b=U5keYFyNa/aUCtaGmgrHIqEF8PUG4suBokOW6RsG/4PqijKlyDb8ynupOTMNFq55R64TZ4bUDfpnIr8M9NmgyMnW87qGNLMpWhuSLH/KXN2a8UfJGqWwGmNmuFK3EtJJR5Y8D9p82MK3Uw8WLUfuv+U23EvtDQCUdudKeviSIHw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.13; Fri, 2 Oct
 2026 18:28:00 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%6]) with mapi id 15.21.0496.010; Fri, 2 Oct 2026
 18:28:00 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Namhyung Kim
 <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo
 Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        James Clark
 <james.clark@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Jiri Olsa
 <jolsa@kernel.org>,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        Adrian Hunter
 <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Alice
 <alice.mei.rogers@gmail.com>
Subject: Re: [PATCH 0/2] perf script flamegraph: Fix input file name errors
In-Reply-To: <CAP-5=fVkoy6ZJ_3Y3E2s=7ccdQd3aUz_g-e6ivX68=aHBsmnkg@mail.gmail.com>
References: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
 <CAP-5=fVkoy6ZJ_3Y3E2s=7ccdQd3aUz_g-e6ivX68=aHBsmnkg@mail.gmail.com>
Date: Fri, 02 Oct 2026 11:27:57 -0700
Message-ID: <87o6dc9cuq.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:610:119::16) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|BY5PR10MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 18089c52-2067-4531-459c-08df20b2e35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|18002099003|22082099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	1wpXQREPgDPe2bCVeuivW1JKTLUzzoyDgKLwWW0udfWTZWxqESghtesi6ZKFuVfRpgPnpNHpgjKsdqg9S2cBnMjJZJDFMcxmc2ekH8Kw2D9t9stg3SDG/LQIK+r08OET/k/jRluH1W77udu43yWyrVyYLJdj+zmnUUpQG7i8VcWKj6Rd1TBsYFTpFMKWfRKUPJBvyHYNRPR3lYu0Ikj/ztzSiy3yIjE2eDW5WAhRyxqs7RPDfX6wCkCDvTw2TSDq35FRwERqWbjoB/R362PvFQ5NFORLnH2gUW6QvNowhzfOROEyJ6aXGkGq1VeH8VjnqdDiQ9r2rT1wtRwBR3bgzzCaNoea8TNZp13wGnxMrd0Y+nR2lEBia3jduB+NoqmZmgo/amb8aOhQQg+GG67xct0znCnwBq4v38hPQM9R9Rsga9MmFNnE+fgFOweluldbz5XCyjOszDuKUXH0qjTRkwISt/47SVkD0Z/xB1Zj8SJmv+ckuFVcn9PhZo73uDB4/F5Q84G3v6OI05V0vU6IYuE/AdboWtB14eIeCHNbjJrGPHKvt6iyyE0gpT4S6viWUTijEn0l3a6BI4pXniwE8bkgJEVycYcUTYxJ7da89ulF4lH7XEv6WOlEHGk+rdgkR1Xp6fRz4dJyteshIAQ5Wbq1a+mPfbCyYTnuxQn9J58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2NWRnFCYVVVY2dDMGVqdGNiZTdGTUZXVkYwODErVThWZk5na2VmS0VDV1Rq?=
 =?utf-8?B?ZWFMdGRJNlU1TXlPRTRzM2ovVUlTQkN3eGFKc0ZlaFlXa2o5NmZRQXV2WjUx?=
 =?utf-8?B?bWdpYWRJWlo2aW5SbjVXTUU2K3BXQUY0NEViWHF0ekZqdnduam9NVm1YdWtt?=
 =?utf-8?B?NUJPd3NUdHlJM2swc0RvVzRJa1Z2QVBHbHJRb3JTb1U4MjJXUmxGakRvVUlC?=
 =?utf-8?B?cWs0YldkUHlXR2grTGNqZG9FUXdieDdScGpMa2xDcVAybDk2RGJRbmo1aGM4?=
 =?utf-8?B?Q1A0VXNBVUhRaTFYRmJVeDlqSDJ1aGVkNVBiQ1BUOEJ1alc3WkVTNEJRQnoz?=
 =?utf-8?B?QmFGWEVFQkdCaTJaMTJUajl2MXAyZG5sUklBME5tUUl4WEt4Mjl4UXNMZXh1?=
 =?utf-8?B?Qnc4N2E0NEtWWEpRbExNTENTamgyTVdKTDlmZGQxbm1vdFJJK2EwMnZ5ZkJs?=
 =?utf-8?B?OWdseXdVb1FNVTdpTmVhc3orVlhYSWRmMkJrNUVnQUx5R0x2eVg3cGM4c2xw?=
 =?utf-8?B?amRxbG90L1lNbDMwV1J1Q2ZsZ2NGaDFtUmlNc2hCOUlLVGxWaXc2Q0k4Z0x4?=
 =?utf-8?B?aTNtd25oR0lEUk1Lbjk3OEtDYWtpVXBsKytsTU9ibmp3TEJBV0ZMay9rZ1lL?=
 =?utf-8?B?OWVLOUorbEFFUEFPT2szclFNc3BRK00zZzJXaFZmaHdjUGZKYTg3SVE1NGxM?=
 =?utf-8?B?THFwSm5DS1l0elo2Q0gwYVcraVdOQjduMFRZc3BEeE9qWXd1YkhtNFNYLzNq?=
 =?utf-8?B?SFpFUG45cUJmc1JFRlVLY0JxZy83WUFvdlc0eGVTd2NEL3R2c2hvdlg2Mzhk?=
 =?utf-8?B?Qjh6VWFIK20xVVVaRkZUaENIK1FLb21IR0JERGRjKzBjMWtGZGFVd0J4Rkdl?=
 =?utf-8?B?NGYvd0w1dmRySTE2K0ltRmloWDNHV1dwMElGOWNMc1M4b21pekVDMGk2ajcr?=
 =?utf-8?B?ek1wRVAxTVFoQlBSaFg1TzdrNW1LQ3RQbzVDZnJuaVBaSkR4VGdFNmwycTFn?=
 =?utf-8?B?TUhGYUlkYTdkS1k5ZG05S1FtbCtaMmNzbHZ1dTJhMkRsSjZmNU01SEdyc0hU?=
 =?utf-8?B?OGpLNUJjdVovVXNlWWhXMjQwaFVSdnVaakM2d1lobVFTR2ZzcXBsbjdibUJx?=
 =?utf-8?B?VEtOdU14UlhNa2U3bjdFNURyUUw3amlTYWdVYStjWDFqZ2FFMnRqRHpUTGVx?=
 =?utf-8?B?K05PSGs2eWRzNWtRQW5tYWdleVpMZC9qUmlzZk9rWUdKak44eHZwb0I0aWhr?=
 =?utf-8?B?MUI0d2o3RmY0RUp3SHh2S05oT2tObDlLRVE1bmx0QjJjQ3ZIa3dWQ2tyL3hH?=
 =?utf-8?B?OTd0TFk2SW1LYWs0WWs5L3JGakpYcTBNTW1TMmZOV3FENVgvN3psanFvUlJx?=
 =?utf-8?B?RFltaGsvaVpWbHJxaDEwRDRHTkhiWStVdVRQOEF1cDVZcXJETng5end6WnhE?=
 =?utf-8?B?eW5kNHlTVzlGUlcvOVRVNXhKM0ttd3BvQXZ2eUlHM1NrYnpXRU1BRG4zNzVW?=
 =?utf-8?B?aU4wTmFwZlFyUzh1NGNKaDE5aldUU3MybmNtWFZCZ3NwMm4yRWxnUlhMeTdp?=
 =?utf-8?B?QjBlTE56Ump4MG10UE5vSVNUS1M2ZnlHVk81bjR1aUZVWCtpUnZ2TlQyRWgw?=
 =?utf-8?B?azJZaWNDYitlUmdvWHFVS2JQaVFIWnhkKzVEZEVPaEZKU2I3SkZGSW1DTjZI?=
 =?utf-8?B?UFFmWW01TmZHWXpBbjBYR1NxdDI5Q3dTUGRiQUZiTzNrSVh0aC8vR3pCRU5M?=
 =?utf-8?B?RGo2YkVPMXNJNitlNG5VeUdBSHV5TVdrdEl6WlFCZUE0ZW95bG9wa0FjSzBo?=
 =?utf-8?B?Wk4zU1pqWDkzdlVHa2pkWEY0YkNwR290NFkzL0JKc3BvRm1hSmRmNzkwMUx1?=
 =?utf-8?B?M2xBUWQwN3VsZi9nakgxTU1oZEFENml0TTVXOGVKU3llK0FPdVhWVTVSU2Jt?=
 =?utf-8?B?Z3lLME9VUHdXUG93TFR6VTR4bkJ1Zm1saGNSa05kWjRFNVhyVnlyWVRvbE4r?=
 =?utf-8?B?VUNvZjkxbDlMZjY4cnZiWUsvUXJRV3RnenhKcWIwNDZLWFVEblZkWnhZSVF5?=
 =?utf-8?B?aGs2RXNCUlIvY2E0WVB1cE5ROFk3YzQzVFdPV0VraE5yaGNud1kxT3NrVkdH?=
 =?utf-8?B?RjZxNzVZd2NDVDRIMUxFMmxzOHJVeEt0YlNTa1RPWDlhRW5nUFovR3JmRzRq?=
 =?utf-8?B?VGRCczBrRlB0UGR6SUZ0SmlPc01qRk9jVGNBMUI2dmpTMlVVNEZpVVBQeWNL?=
 =?utf-8?B?T3hCSWQ2NnRLWmhsNzFkN3AzYlBEQ2dhRDRJaERvcWg3R2N4L1R5c2tPOU5B?=
 =?utf-8?B?OUlkQmNrNmtmUVZZeHQ1YnF6ajF5ZXZ4MzU1Umo3SUpVMVkybXVQQzZUdzBU?=
 =?utf-8?Q?ApAUQI/U34FJ2CP4=3D?=
X-Exchange-RoutingPolicyChecked:
	sdJWMBQWFdPRFuL3tlZGzp2fk+wnWS7PyFTvsH3IvQmFzq4WLUKBwhY5wigMxRgOrdRO+V/ZQXKSSSX8S72h7cfHksgQVy+8iA687ZGiI9CISQAXy1nzgIKprU6dNj8T0C1yQJtZW8/RxTRbj8r0FVtcVwDJ+UHJkZOMsiKbSerEfiKZHK5V+wCr730K1TIB6KvxL59vkk5jruxKUHQmXiuW9RFCL8vctusYSF5Fsqn4B2++tTCo8LbF9AnlgelvbXe6S82lz0l+2e1DzREtLohKaMYXEb6t4CHbr6UnFyF+L17Twli+JIx9IZODp1UcyUs3exPwuCeRRhgWMNEAQA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	puI1iaKE30VgASOYWmcfacrIYQJPKgtRpkTVUC4zJwofKHWLjqZ2m9eOT9HocPtmjhx38uB4e4E1JY7PS+5rR6PQbFA90tv7Gpi/7CwvFN6vAg0UmhrgIq1Wcf1T6HLTu1ffhenQyJ45XsDOzBVCd61RZDj0Aj+D8sxymqafwkufHh5R75SjvvjXur/8xotfJa3QdTlU2lTMjuCEecMJPAxrizYEf2VpYhiCCDUWoTupBkO1Xc0jQIhc7+vTE4huS3Bn0VPItu0tQc3RI/+FBjwE11BGcW00ouCrGaNl8VasELnP8xopb6REztyypRQriADrKpknuNW3gSObKP7gl/QHn8sxN1ugOo1sR7T7ZUmDzKk8SkROQW/CcizGpR5iPPvWTij94dldHN9+EH09GN+E8KAezSn4VsTx28bKCq4mvQEWkM4b5hWowhdyTvZ7dFror8R9OYUQx12E7Lzcow9BeKPImE4eIuG0Y53HfMGhOHb45uEnre/jyQHh/qza8WtmCy1YXmzgE4zsBBmebn99ZNJrphNXuzlO5ZEgHMiqCYroDWbNGLPGcnoK10uSvmuSS1W+QhNksMjhVhzqlLTHPeF8AGpvCx7nLOHMDzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18089c52-2067-4531-459c-08df20b2e35d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 18:28:00.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGYV4FN8FyyGU7iUX0eKgtajQVhteM2YMmcNhZ7zTAz7bDYq/l4i28A1Gaxo7t/Ng4Xwj9oyu2Kezow+LLhwghMHZxTIFWNuLgw9YeYUINw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020073
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MyBTYWx0ZWRfX5RellY0g/P9j
 ruiYN/zeRMQRPlLk54rke6IzSp/xzIj2melB6CwyBqpuv2sUvwA73NalAp32Lqw3P71+EVa8077
 Qt87FMZYjwV9GYMf0dvneI2VtO61CJUu764lQVNdciyI5HcFq/MW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MyBTYWx0ZWRfX5ziut9BQB9fd
 LmjsP4SB/ub29jmqs7bDL2ppBPHWInGFPtMbnUxYN57KgGuqWYsrrgSO7wlj3YqM0YNrfhwIcjQ
 VmSP6OpUjI7ghGFS8sanDFPDhKckjRTwkbH/ruR2iqUKD25b4nqAfDJdIpNsloh7hXYO7A+Z+2e
 gbOKfdUvIMK3SFIeml0kW2m8SJeuOUB2NYeQja1W9mz91zW3btL97YeLKkat8D3UQyL55g+aV15
 hoSMZTCOXJO2ng6h1VVjUM6E/lVue1ud+k5gc+3vIPsSB8YG1yNPN2fER9TQxN2L9qf2n8AGdbW
 hyGzcszS4caXuMQoizmdzT6hrc4r4rm3JbP8ZRqZrQ+2eyMz+uGwGIpT6IsAMEi2yzCEag+lX8I
 +6G1ZdourPoeVwwMIb6eQSU/20yMFxunB8MSlwQ9LpduhlUJ9vsBQMB/L0r4LDBbgAJK1w8/FqK
 /k2UM+oPRzr4VGUhIFA==
X-Proofpoint-ORIG-GUID: lUSBwQ4GBDBz52pFj_t-qkKdmcYzoGtn
X-Proofpoint-GUID: lUSBwQ4GBDBz52pFj_t-qkKdmcYzoGtn
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abff7b9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=yJMZlIcQM3o1iPV7IOcA:9 a=QEXdDO2ut3YA:10

Ian Rogers <irogers@google.com> writes:
> On Thu, Oct 1, 2026 at 11:20=E2=80=AFAM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> The flamegraph.py script has a "-i" option which it uses in an attempt t=
o
>> know the input file name for the data it is processing. But perf itself =
is
>> using that flag and not forwarding its value to the script, so the entir=
e
>> strategy won't work. It's further complicated by how the option processi=
ng
>> is handled in the flamegraph-report script -- details in patch 2.
>>
>> This series introduces a helper to allow python scripts to see the input
>> file name, and then fixes flamegraph.py. Testing with a variety of optio=
ns
>> like below shows that it is using the correct input files in most use ca=
ses
>> I can think of:
>>
>> $ export PERF_EXEC_PATH=3D$(pwd)/tools/perf
>>
>> $ sudo -E tools/perf/perf script flamegraph -a -F999 -- sleep 1
>> dumping data to flamegraph.html
>>
>> $ sudo -E tools/perf/perf script record flamegraph \
>>                           -o myfile.data -a -F999 -- sleep 1
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 2.891 MB myfile.data (1832 samples) ]
>>
>> $ sudo -E tools/perf/perf script report flamegraph -i myfile.data \
>>                                  -- -o myfile.html
>> dumping data to myfile.html
>>
>> $ sudo -E tools/perf/perf script \
>>        -s tools/perf/scripts/python/flamegraph.py -i myfile.data
>> dumping data to flamegraph.html
>>
>> $ sudo -E tools/perf/perf script record flamegraph \
>>        -o - -a -F999 -- sleep 1 \
>>     | tools/perf/perf script report flamegraph -i - -- -o manual.html
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 2.936 MB - ]
>> dumping data to manual.html
>
> Hi Stephen,
>
> Thank you for the contribution! Unfortunately we recently deleted all
> of this code in this series:
> https://lore.kernel.org/linux-perf-users/20260926062029.800743-1-irogers@=
google.com/
> You can find the latest code in the perf-tools-next branch:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/

Hi Ian,
Thanks, I should have checked there first.

> The flamegraph code that now uses perf's python module is here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/python/flamegraph.py?h=3Dperf-tools-next

That looks exciting! It makes things a lot easier to have perf as a
regular Python module rather than wrapping the interpreter. It will be
tricky for Oracle Linux which allows parallel installation of perf
versions, but I guess we made our own bed there :)

> and we even have some tests now:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/tests/shell/test_flamegraph_python.sh?h=3Dperf-tools-ne=
xt
>
> You may also like to play with the console flamegraph that is part of tre=
port:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/python/treport.py?h=3Dperf-tools-next

This is quite slick! I'll definitely be playing more with the python
module.

Thanks,
Stephen

> Thanks,
> Ian
>
>
>> Stephen Brennan (2):
>>   tools: perf: add perf_input_name() helper
>>   tools: perf: flamegraph.py: fix "Error reading report header"
>>
>>  .../perf/Documentation/perf-script-python.txt |  1 +
>>  .../scripts/python/Perf-Trace-Util/Context.c  | 16 ++++++++++++++
>>  tools/perf/scripts/python/flamegraph.py       | 22 +++++++++----------
>>  3 files changed, 27 insertions(+), 12 deletions(-)
>>
>> --
>> 2.52.0
>>
