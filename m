Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3133227B96;
	Tue, 15 Oct 2024 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028267; cv=fail; b=R/IQoi0IJPIlSuqRMzIpSdrsrZTQv03JbAgaJu1UXYvWc0LXYCDIqqkSgIm2YRE7EXTRl2wqG9f/BW1i2A3rsj4555zaVehhn3pnR13+pWmuxHuBMYcDBvY2gqjjNRlWjVmSinZG9xXm/gQJnrndXFqtrg49sSeWsW5sKhSMLa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028267; c=relaxed/simple;
	bh=eXb/9GyMTVt5tCfwVoBUruwS1JqfLbGs72vsHM6vrvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lcnufIjJqKGzbeYy4bKDaoz/Mf0W7VJ//sgvj2TbfvrVHWqCZHEQNkbIa9IgA8k+8cYfMMPasCvDZjlMxh9wsZ8BSwdS2Q3Dwdtlcsms7XERDACv255h2FxbTtzTBCkUndOMBhcnit5wEQW43h+vsknybZqmzcrOaOxlyb2wN4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZXQjRh1S; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZXQjRh1S"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49FINd0b013536;
	Tue, 15 Oct 2024 14:37:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=eXb/9GyMTVt5tCfwVoBUruwS1JqfLbGs72vsHM6vrvc=; b=
	ZXQjRh1Seg87qLCEBekcBX+AImb+jjRHFYStV6xI4vF84iinwf/KIf0tCjxuJI1O
	/3h2bIZKtntJPRHV3qg2eIfj65FMaXxIl4Ni4eJ9uuTLtSLrA6u/lPeXAe6H9fAi
	y4kjTgSM9szVgBWUMvB67m89j+n25bCLVQPUJ/eG6ZNRqfgjSktsRHUzA59ar6yU
	0CxojK+wxIWZkdknbT0Mmc8cRdQJgUjd9PFFEoTWsGzUuuAJFAviR/A3RiqFwoYv
	WcnxwTIkIhf7lpzty/mO4i605dSl4a6TbCYYaX+2cPLt6k7OLIQVDxNcl1UmeILm
	qscnIrkAMUr2sYJuisbnfA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by m0089730.ppops.net (PPS) with ESMTPS id 42920p45tg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNV62GFqc03HTLJ9tSR2GVq503Nw6rm5iW+i5EK5WllJ55F5f1hxBqK/RAsIX2maYVH25YgKQfjktGcmn1LoZbnT3Squ/6+2bjnPHBlp4gnqdwdDBYNvtyMgStpyHQlrQdYcolWFSy7OzNAbWp/a6ivmLIBpRenip4mBEqc8nQs2shKxtOhlRDC+2zGC19m1EDoizjtGX8638Z++YAeOlagLUxokPDYWvcIrWQ3XZrHP/RwmI7frwuqg9xD8vNRi9zd3P8pzXvuI0ZgRDBm+b58Hjn3P0eNncoy1MuJ6c7XvoAFRBukq8buH6lCBYq4Do9bC2haSuk88Z2CZCwKqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXb/9GyMTVt5tCfwVoBUruwS1JqfLbGs72vsHM6vrvc=;
 b=Dy/Tr71uIPiZaRjqZudGjtrpeay7lRk6iQ1ZYGSt+2J9Q0Eu8D/pteoARORFDdV5J26UOFHf4SxYK9PAJOV5iHkkAkcxHfDIellt8+lbFKQl3YOyTsJ4XTB/TYVcV1UUB/Fh5Cqjc7GtkV/bCQE3J+ApliLnyLsNtyJQiugyarlRYh8ZhKDdIJY3rwzv+kfoSGWAB3utRAABIKtJzeNDqGDmFjAXfWGOj7WYXlapkTaRqbz6FgtYby9FTQHZGfiZ7FALyRPbDN1TM3fuPvCJQO+JZd0nNhmn1O15edLtBNBVd3R9oTL+ggKi8NQFUKy6kFTn4BAVyVdvsDJQTSkdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO6PR15MB4161.namprd15.prod.outlook.com (2603:10b6:5:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.28; Tue, 15 Oct
 2024 21:37:41 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 21:37:40 +0000
From: Song Liu <songliubraving@meta.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>,
        Andrea Righi <andrea.righi@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-use. <linux-perf-users@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>,
        "james.clark@linaro.org"
	<james.clark@linaro.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature in
 clang 12
Thread-Topic: [PATCH v2 0/2] perf trace: Fix support for the new BPF feature
 in clang 12
Thread-Index: AQHbHzliofByVWtRGEeIpmwTo98uyrKIOuIAgAAK0ACAABC/AA==
Date: Tue, 15 Oct 2024 21:37:40 +0000
Message-ID: <6FEB3225-9B3F-4ECE-AB68-AFF00F5E03E8@fb.com>
References: <20241011021403.4089793-1-howardchu95@gmail.com>
 <Zw61TUe1V97dKWer@google.com> <Zw7D9HXBanPLUO4G@x1> <Zw7JgJc0LOwSpuvx@x1>
 <Zw7SkmEaz730uVbL@x1>
In-Reply-To: <Zw7SkmEaz730uVbL@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CO6PR15MB4161:EE_
x-ms-office365-filtering-correlation-id: aa073a22-cf93-4ceb-3176-08dced6198b5
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXc1ZjVGL0d4L1pkMWgwSnREVGR2aHZDR3htdVdiMlhmbE5xUUJTbTZjaXp5?=
 =?utf-8?B?OVFrOWtDMHhyS3M0Q0RKa2RsTlNFa1ZWc29zdXNyWElxTVRyczEzZnpWWEtl?=
 =?utf-8?B?YllhMUpUS1k1RGFaa2ZQSTdzVnJZM0JmOTU1d0orTXU5alY0bFdTTXU2bUNQ?=
 =?utf-8?B?R0dwSU85N0VsK2htNE9ZcEx3ZG1jb2xQNnVmNlpQSGRQYVMzRFBkS1JZSXY5?=
 =?utf-8?B?bXVxNHFDMlRUK3FHT3NnVXhJOFJuYlVIdTdTWnFVenB4a2JvQU1WU0FrUSsz?=
 =?utf-8?B?U0pmOHZkbEthdDUxUUpkcXorSGxlZ2lwamhmYW55ck5HSTk3dVBWUTgyOFRE?=
 =?utf-8?B?REpGbXhPVlRrSFBtKzhYcDhRcEFnU2gvdXNzV0kxYWxmbGVrUTUvbStIdXZZ?=
 =?utf-8?B?OUVLNS9zRGlScWcrS2JaaE12TjRwK01BbE5jWVVxZFIyTWhwV2tKRytjYzFO?=
 =?utf-8?B?aExPd0Q3WSs1eG9BTXE1K2NhOU1iY3lIYWVob2ZmMlNpVVNEbHNwOVIxNUdJ?=
 =?utf-8?B?ZDhoSzBzR2RSSUF1bTdta1ByRHdlUWpvZVFRRCtPRHFxQVhxeUZhdXpVeHU5?=
 =?utf-8?B?SHI1SEMvWTVlS0ZlS1NNOUEvUXpyckRFajlDa1hBLzZkdWk4dTlDNHFxQ2do?=
 =?utf-8?B?dkhaeTNEeEZtV1J2OWw3bkJTT3ZEWWJtV0M5OW5qVW5GSGROVE01VzFKNlFJ?=
 =?utf-8?B?WkZ6ckIweWlENG1nWVJ6bEljam5LbDFjUmtadFcvL2RhRjJvUXJDdVA1UDJP?=
 =?utf-8?B?ZzdXVWZqUWZXYS9TbGtGUWQ1U2hERS9FeUxWOWlSaDhOOUpmMEFTVDI5WXpZ?=
 =?utf-8?B?dUF4Tk1yZFZwRjQzbVdaWnZ1M2NOR0ppdUJQYS9vUlpKMS93d05IbHdvMFJ0?=
 =?utf-8?B?WXB5b1lPOTRPL2xhSEVCRXRUZ014d0R6NC8zci9OSFNha0lPaXhoeEE1eS9z?=
 =?utf-8?B?VGM2ektxL1diZ2xVRHV5bURCSzI4N29obkpBLzR1WmRCZVhSdHUzREhsWUtP?=
 =?utf-8?B?MnpROGd2bTc4QUVqeEJyZVlqVlNMVkZpSXNDcUU2Y1VsV01VMzZMaEpJU0Y0?=
 =?utf-8?B?b1ZmUnNCVG1IOWZJVWo0dDNaS215ZnVIUXltbExZZ3hKZ1JOQW1HSVgxRVow?=
 =?utf-8?B?RE1lOU1oekJ1czEwTzBSN3Q2TnhacmRSVUJSS0IwUkZtOVZXTU9QdU5mbnFW?=
 =?utf-8?B?WTR2aW1DNGQrb01hTlk3Y2JmbEtzNUpHc24vbXdGa2E5OFlhMXJvQ3dGT1pt?=
 =?utf-8?B?Tjh4TmZFZzkzdU8xWVBwVGxQL0JTVGVkY3Jock5zQ3htamltdGZGL3FHUWtD?=
 =?utf-8?B?SnMwaXFNK3p2bXYwcmY4Z3dXZnRHdmxiTzhEbmgxWG5qMHJFK2Z4RmZVTUJM?=
 =?utf-8?B?VGJTQ3FRMVVBTHM1eTkzeW1rYVdQQ0JBZ1Y5Sk1XUnc5VGpKR2RRdzNSNFdM?=
 =?utf-8?B?aitJWVR4WU8vZ0RYYk9WWU5rWXl4cEpjZTI3eGM2K25RU2hJUG9vdDRDSGRT?=
 =?utf-8?B?VFZoM3hBSmN2NVB4bFdZd3NVc3lKN2FRZ0h1SlI2MEZvcU02UW1SK1BqRVNx?=
 =?utf-8?B?VGc2Y2hjT3J1OUkrVVpvYzhZZFZRVWdFMHFXMG1EMW9PSCtFUUJDZzE1TGVo?=
 =?utf-8?B?UXJ1bVRWbGtHQXJSZU1DamgxTm5jaDhsTG9uUnI3U0N6cytEdGJUQ29IZGFD?=
 =?utf-8?B?ODFEUUVzUnhZeFM5Zk1uc2FPUjlqRTZaRTFiVXR3SGo0eiswVG1BaFl1Z2I2?=
 =?utf-8?B?Ni9HcUhTM1FSSHFNL0lxaCtGZzdvdzVRNEsyL0xNQldrUk04V25qekpXSml6?=
 =?utf-8?B?dzV5VndLMTN0SzdORUdMQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um5vSXFwL1g4OTRiajhscnJ6TVRhTEMxVmtUOS82T3hza3p4MnltQ3hCZVhu?=
 =?utf-8?B?ZGxpZmYycHdEdXVIQlNhSlhvNlFMSzVYM3lJM1VQbEFhbDdyK2hNQVJqMUNp?=
 =?utf-8?B?U1o4V3hTMVBRcWQ0WHZsUmF0VVpMUzdzRzZQR1djRWo4M29LUGJrQW42cTgr?=
 =?utf-8?B?dmlyN0xiaVNCL0g4Y2FjZVh0ZERFREFiV2hpc1lSWWtRZ2lwU0NybjZuMUhY?=
 =?utf-8?B?SDZncGtWNDZVNzBsT0FqOHVXd0RRWjNrZ24yaTlDcHd4ZVFHUjN5WmdiZmNx?=
 =?utf-8?B?bHA1QVJXQkExN0NSSnB6Y0hsbnU0MTI5cHZzUzM3Qk45NXAvdW1ma0V4bCtT?=
 =?utf-8?B?dzFLbGtCUFJaaStvekU3RmlOWFBSZDRtK0dHRkM4UDNTYjJuMEhiRThsNWIz?=
 =?utf-8?B?cThhZ2YxbUpTUzF2MVYzQlF1NlkyNzFNN25XRzVrRjIyM2lKMjRFOHRobWRl?=
 =?utf-8?B?RVU2NDZHcFBseFRyblFucjlPaCtGc2FXWmJoNmgxaTZpcEYwdTJRU3k0QVI5?=
 =?utf-8?B?YXFZKzFDWW9saDVMVWZQMzk3ZzRLT1l2QzZVSmdSVXh4NFU1RG1BbkN3dVN0?=
 =?utf-8?B?bU9wSzFpM1pFSlkxWDlaeURkSmphMzNmQ1lYWjk2Um9nTjdYeFNJd3RDcjky?=
 =?utf-8?B?WlA3OGh5bVdkRlFJcnd6bEd2bXdTTEladm9kRkdndmpDRWVtOGtmMGZ6Y1Q2?=
 =?utf-8?B?VHVrVTlsRUM3aEdPRHYwMVNiMWhZQzAyY2I5dEZhVmlKakpJRTVXSlp0OWFo?=
 =?utf-8?B?b2dVVU82Qkg0TUdCclhSL3Nid1B0TXU2RmdDeWhobERlTzlMRERsMGJ3bEpj?=
 =?utf-8?B?T1RhaGZlTU1pQk5wejVQT0JiL1Z2S3FiRFo4MFE5WFJVMmFQSmdyRVZHeWtE?=
 =?utf-8?B?b2xKWEdNa3lzc2ZFakxkVWlId0d2Qnphd2FzeTNaVW1GZGYvMk9HYW9ocmdh?=
 =?utf-8?B?ZkpueXRjaWlZWFM3RjlRR0pDdzhySnJXRWd3OG1Bc1VCcnlNdWErTDNkQjh2?=
 =?utf-8?B?WENMUHhRUVppUkxrRDZLa2FtNFdYaHd0bjVGRG9sTzJ1K3B0b3Z3UGgzN0ZD?=
 =?utf-8?B?SDVGaEp3dnMyd0R5K014dHBvcldmbEM3NlQxcWhpV3hZN0NDa2d6aGg0eG9k?=
 =?utf-8?B?YVRkOWxoRmEwWUoyTThuaHQvcU1sdzE2eUFyNm1rWS9mOXpzRHYybUV6ckY3?=
 =?utf-8?B?eTcyU3lYdEVIR0Y0cDdoSGo0bDRVdFNVTnVGTzBLOEREbXhTTkU3WExESS9Y?=
 =?utf-8?B?SFNFSkpaWWJpZ2tncGYxMHVGMFdGMTBadWgrb3BQbWgzODVmRGRvcWowdlFS?=
 =?utf-8?B?Um5CajRhMUFUSnpma3B2R01oY0dadTF2YTYxNk95NW9ZNHhCdGxCaHRwNEtT?=
 =?utf-8?B?YnluVmhlWHpTNi9xbTdLN0hUUkpad1NTRTVtUzJuTFJCYmFDajFVVEhVVEpi?=
 =?utf-8?B?aXJsd2F4Q0J2c1BwV05vMDczNDZNOFlPcEhGemxqZ0hnSmJybUhzaWQvdkto?=
 =?utf-8?B?YkE2Tld3cDA3RWMvT1lYVzBod1ZGL1FqS3BjbzlJaER6VVNrRExJVDhJcmtk?=
 =?utf-8?B?b3grS3FIQ0V3dWIzOFFIa3EzVFVIMGlxZ3BoTmpLOXg2ZDBiN0gyQS9BVWFl?=
 =?utf-8?B?ZlBoK2ExWEpQcGhpc3ZFUWlGclQvSmdTUnFQamxvTDVVQ1pEVWdSQlVJQnhJ?=
 =?utf-8?B?VUozdDZWRS8xNDVTMFI5TzVsT3E4OTYrMnV5SG5pNU1ieldKUDg0WXpqenRo?=
 =?utf-8?B?d20ybXJORDExc1RZamZWQ1g2QjBjbkRiRzZ1OFNLSS9UbVdZaXJaeWdCUXZk?=
 =?utf-8?B?cEd3cU96eW9xS1lwVU82Y2tZd1RVdjk4RFNNc3drMURFbzlvaGVSSXFURXJQ?=
 =?utf-8?B?VVdyUUpaeURjUGZ0clJTYjBvRnJXZXplOU9uT2lOZnlQUERSZldhdTNSYlF0?=
 =?utf-8?B?ZlcxcFBrUVplbjNKWHgxU2FCYk02Z2tjaENSanJvS0xzTnpmKzRoRWllVnh3?=
 =?utf-8?B?SG1sdEM2N2c0KzZPTGlST2xRZU9HbjN1SjVVKzRNcVJsQ1lEQ2FwaFp6ZHdL?=
 =?utf-8?B?eHlEQnlqZVlNM252UVpqcnNTYWsrVEFidlJUNU8weFpnRk4rOUtuTHBRcHNC?=
 =?utf-8?B?a0x0VFNiUHhuZXJjQVlCTlVtSS9uY3VJUmR1bElGOEp2QU12VW0zclUzYUla?=
 =?utf-8?Q?kmkl6wGHNZ9HVXM1kP62s80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <794D0112706C5A4D95B44031B1FC9C3C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa073a22-cf93-4ceb-3176-08dced6198b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 21:37:40.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGsKVtvFKzlMslzoFSTmA+579IJOqqMs5ekc1mV2CnBW6fMnUcskLG15yGNhM/2Cr7ok64fGVBx72YtJqfqNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4161
X-Proofpoint-ORIG-GUID: JvRFk07VbOsueZ1EnXweu21v8oQJrzbl
X-Proofpoint-GUID: JvRFk07VbOsueZ1EnXweu21v8oQJrzbl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

DQoNCj4gT24gT2N0IDE1LCAyMDI0LCBhdCAxOjM34oCvUE0sIEFybmFsZG8gQ2FydmFsaG8gZGUg
TWVsbyA8YWNtZUBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgT2N0IDE1LCAyMDI0
IGF0IDA0OjU4OjU2UE0gLTAzMDAsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyB3cm90ZToNCj4+
IFNvIEknbSB0cnlpbmcgYWRkaW5nIGV4dHJhIGJvdW5kcyBjaGVja2luZywgbWFya2luZyB0aGUg
aW5kZXggYXMNCj4+IHZvbGF0aWxlLCBhZGRpbmcgY29tcGlsZXIgYmFycmllcnMsIGV0YywgYWxs
IHRoZSBmdW4gd2l0aCB0aGUgdmVyaWZpZXIsDQo+PiBidXQgZ290IGRpc3RyYWN0ZWQgd2l0aCBv
dGhlciBzdHVmZiwgY29taW5nIGJhY2sgdG8gdGhpcyBub3cuDQo+IA0KPj4gT2ssIHRoZSBmb2xs
b3dpbmcgc2VlbXMgdG8gZG8gdGhlIHRyaWNrOg0KPiANCj4+IFthY21lQGRlbGwtcGVyNzQwLTAx
IHBlcmYtdG9vbHNdJCBnaXQgZGlmZg0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9i
cGZfc2tlbC9hdWdtZW50ZWRfcmF3X3N5c2NhbGxzLmJwZi5jIGIvdG9vbHMvcGVyZi91dGlsL2Jw
Zl9za2VsL2F1Z21lbnRlZF9yYXdfc3lzY2FsbHMuYnBmLmMNCj4+IGluZGV4IDNiMzBhYTc0YTNh
ZS4uZWY4N2EwNGZmOGQwIDEwMDY0NA0KPj4gLS0tIGEvdG9vbHMvcGVyZi91dGlsL2JwZl9za2Vs
L2F1Z21lbnRlZF9yYXdfc3lzY2FsbHMuYnBmLmMNCj4+ICsrKyBiL3Rvb2xzL3BlcmYvdXRpbC9i
cGZfc2tlbC9hdWdtZW50ZWRfcmF3X3N5c2NhbGxzLmJwZi5jDQo+PiBAQCAtNDg2LDYgKzQ4Niw3
IEBAIHN0YXRpYyBpbnQgYXVnbWVudF9zeXNfZW50ZXIodm9pZCAqY3R4LCBzdHJ1Y3Qgc3lzY2Fs
bF9lbnRlcl9hcmdzICphcmdzKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF1
Z21lbnRlZCA9IHRydWU7DQo+PiAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHNpemUgPCAwICYm
IHNpemUgPj0gLTYpIHsgLyogYnVmZmVyICovDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGlu
ZGV4ID0gLShzaXplICsgMSk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpbmRleCAmPSA3
OyAvLyBUbyBzYXRpc2Z5IHRoZSBib3VuZHMgY2hlY2tpbmcgd2l0aCB0aGUgdmVyaWZpZXIgaW4g
c29tZSBrZXJuZWxzDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGF1Z19zaXplID0gYXJncy0+
YXJnc1tpbmRleF07DQo+PiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGF1Z19zaXpl
ID4gVFJBQ0VfQVVHX01BWF9CVUYpDQo+PiANCj4+IEknbGwgbm93IHRlc3QgaXQgd2l0aG91dCBI
b3dhcmQncyBwYXRjaCB0byBzZWUgaWYgaXQgZml4ZXMgdGhlIFJIRUw4ICsNCj4+IGNsYW5nIDE3
IGNhc2UuDQo+IA0KPiBJdCB3b3JrcyB3aXRoIHRoaXMgb25lLWxpbmVyICsgdGhlIHNpbXBsaWZp
ZWQgcGF0Y2ggZnJvbSBIb3dhcmQgYW5kIGFsc28NCj4gb24gdGhpcyBvdGhlciBzeXN0ZW0gKFJI
RUw5KSwgYXMgd2VsbCBhcyB3aXRoIEZlZG9yYSA0MCwgaXQgd291bGQgYmUNCj4gbmljZSBpZiBz
b21lb25lIGNvdWxkIHRlc3Qgd2l0aCBjbGFuZyAxNiBhbmQgcmVwb3J0IGJhY2sgdGhlIHZlcnNp
b24gb2YNCj4gdGhlIGtlcm5lbCB0ZXN0ZWQgYXMgd2VsbCBhcyB0aGUgZGlzdHJvIG5hbWUvcmVs
ZWFzZSwgdGhhdCB3YXkgSSBjYW4gdHJ5DQo+IHRvIGdldCBteSBoYW5kcyBvbiBzdWNoIGFzIHN5
c3RlbSBhbmQgdGVzdCB0aGVyZSBhcyB3ZWxsLg0KDQpJIGFtIHRlc3RpbmcgdGhpcyBvbmUtbGlu
ZXIgd2l0aCBjbGFuZyAxOC4xLjggYW5kIGFuIG9sZGVyIGtlcm5lbCAoaXQgaXMgDQpvdXIgdmVy
c2lvbiBvZiA1LjEyIGtlcm5lbCwgYnV0IHRoZSBCUEYgdmVyaWZpZXIgdGhlcmUgc2hvdWxkIGJl
IHNpbWlsYXINCnRvIHJlY2VudCBrZXJuZWxzKS4gdmVyaWZpZXIgc3RpbGwgZmFpbHMgdGhlIHBy
b2dyYW0uIElJVUMsIHRoZSBjb21waWxlciANCmlzIHNtYXJ0IGVub3VnaCB0byBqdXN0IHJlbW92
ZSB0aGUgb25lLWxpbmVyIGNvbXBsZXRlbHkuDQoNCg0KVGhhbmtzLA0KU29uZw0KDQo=
