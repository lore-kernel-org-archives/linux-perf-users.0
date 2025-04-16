Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776718DB05;
	Wed, 16 Apr 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830933; cv=fail; b=WMAKCQzKNwrYXilrILgJXw46EbPkiGOpRr525Z1x3JqbLBqQyuijCgFXGEr1MyJp252E0W9etLjKR3lOrN2k4hrcmm6b1UEyeZj2Vm5j1VMjwzbzsxAk/T05UGN6zk8qgFo34Q2WDNW6bJFmyNd5+3pze91dbw5ALaQCTBohiq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830933; c=relaxed/simple;
	bh=QCQTHgMTiZQ4wbBHXU5Wtxvh+qHsh/n84bc7F/j8A/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f81hXuad1P+eBXi0FKbHZtP7pfw7e5P7PturBm/HS0bTbpU+fMm/hcExdukUbUnu128f5WmrbPkg8Mq5bU3KKade6L0CQSE4AHuK18uMENWq/GmC3QQmq9YJfyqmJ1FvZktA3VWavwB5LuIrL18alggFOy2jDFXt4IDB5Cl/EDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=KkqbyR+t; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="KkqbyR+t"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GIHkWD019681;
	Wed, 16 Apr 2025 12:15:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=QCQTHgMTiZQ4wbBHXU5Wtxvh+qHsh/n84bc7F/j8A/0=; b=
	KkqbyR+tv4XQeO97BbXdB4Ri6u1HaaO1vig36iZ1ZbmXnnNar3gv0mVfB2uwa/hY
	T16ytXftyvSalHAMQ5owgcb8mIjRhGiqjfR7+XRI4/5KsnkII9fmXNK0MslWbvK6
	B+3lrxs5vX030Z/oAxIUBTexmMtRw9Mh5MPfHuKXMYTTeQY+73eZfK7LjuZVB2X0
	zosYDfj/kba9guCSF7KrYeG3M+1HzePclaVDFn4FLz3oZ9Qw0VWv+KRTnxG99kjN
	FQBd1Ybwe7OT4iIcqX2k9i0lkIC/aUcrQkWXAwCHjOz0+DMdqHC67QjgdyK2P3yK
	XjRBTRMJ3q6bN8pMQQjIaw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 462aj5v7qn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 12:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/BPY7elk659Yug8bXVn8tnBVug1woWHpGsoj01sSWU26t+xoBhCyHXZ0OGAdwBaERWyPvPWsrlLSfUxCWPJbPv0MQC3MLLxAU1uBF5pblKmz11pMprgrluHGXmurqAbbpfladgY2J61LR0plfOit575WzQ47FtYebxgH8foO0ZaG3wbjitCMhcOwVbLrL9XqngG/TuTEM6qKCE36/WOJfSYi3oOfHmTjcmcpyf7cooGFAzm7Rt4mP/kb+K6ZVtO5K4UPr3AbrKC+3AYzd5mwdh81wHj+/17nLQ/ifuLXcw2mObRq5pxHc/6kMjF0RdnSTagr0XxVMuvSBkPsliRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCQTHgMTiZQ4wbBHXU5Wtxvh+qHsh/n84bc7F/j8A/0=;
 b=rOTBjDQImat5tTjuKaBJgFcDaRcPpaR+WhO77OzE4v1EzVCyBUvl7uV9+RVTvOb9MRCEn8v5U8HjropiLIR/tFnrSu6S8+S2wW3GT5RYGuoSvvWqPTF9uDWXeYGczW+uhRAevvowNSErMZajQDmCLN3rMgOIgunsZmVh2zxQaU3DvwehPA791Hyrh7IxrIUtRihXT8Ycn1Dt8mfNzKXNqV6fC5hk8huObfbR/EotxqeGlnBMrDkFZKoegces2tHUOl0Kjcpm0pICpj7vAXvTQtSrVrhBoQQLFxHTig2t3b+5OcPS25YEx+59WBidAS5abAgKUscXmbAIKtKZdSqI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by IA0PPF99570C442.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 19:15:26 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 19:15:25 +0000
From: Song Liu <songliubraving@meta.com>
To: Sandipan Das <sandipan.das@amd.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>,
        "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "eranian@google.com" <eranian@google.com>,
        Song Liu <songliubraving@meta.com>,
        "ravi.bangoria@amd.com"
	<ravi.bangoria@amd.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
Subject: Re: [PATCH 4/4] perf/x86/amd/uncore: Prevent UMC counters from
 saturating
Thread-Topic: [PATCH 4/4] perf/x86/amd/uncore: Prevent UMC counters from
 saturating
Thread-Index: AQHbqSU5Xjpz+HeHDEaezTzBaTExmbOmtXgA
Date: Wed, 16 Apr 2025 19:15:25 +0000
Message-ID: <C24A57FB-5898-411B-90B4-58252BC22CE9@fb.com>
References: <cover.1744184837.git.sandipan.das@amd.com>
 <c8e5808145985bb558d8daaefe42586b74d4085d.1744184837.git.sandipan.das@amd.com>
In-Reply-To:
 <c8e5808145985bb558d8daaefe42586b74d4085d.1744184837.git.sandipan.das@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|IA0PPF99570C442:EE_
x-ms-office365-filtering-correlation-id: a729d19f-c4a4-43b0-1277-08dd7d1b0ade
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFZBcStOdWVqU2JjNTZkN0hRcW5TMi8vZzdnWm9Wb0xZSk1VUjF2ekFYOVRv?=
 =?utf-8?B?OVNkUlZxZ0dOb0lwbmVZNC9ZRVV1ejg3NnVFT2RCVWZndXIwWSs5R0h1TDRl?=
 =?utf-8?B?UDdJdmxVMnkvV0dOTDlsNERTeGgwRi9YVlVpSUJtd1NySElRUGZLTS9vYkpp?=
 =?utf-8?B?YmJ2NkVkZDFsNTVHdDNpNUFVTjRMRk1PRjZTb3ZhNUtOVnJZT0pBb0taSTJi?=
 =?utf-8?B?OEpYcDB1bHBVeUppYXJrSm9QNzNXdXgvOTl4bnNMQTBJbzJvYXN5Z1pva3RN?=
 =?utf-8?B?WHltSTdMZFdSZVBqUEtTbGZ1Skd2bkhHSnNXU0kwWGRkUHdvM01oV3Jna2Vn?=
 =?utf-8?B?WW5sR3hOZG9YNXRjWHZ2OElkSkVPNk9wTGhBalJZQlcwS3dkdS9Fdm5ldzEw?=
 =?utf-8?B?WnRMU2tpTlNuazUzTkdSS0hXdmtoZjhsK0hzbWJMcGc2STFTeXBQZFpuZ3Z0?=
 =?utf-8?B?bjZTNUZ0Y3JPNmY1cHNCQzByeWx5eFREMWJ2U1oram5JejhJUitvVWdOSWlP?=
 =?utf-8?B?a2hFV3dYVVVqYVVxbTNDczlyRkd6SVgzN0ZhNnVIZWplQUgvQjhsRUU4OHJW?=
 =?utf-8?B?ZDZkT3pPam1vYnQ2U3VMNityYjkvY0Z3cFU0VVpMcUFPWXhrWmdLMW92NC93?=
 =?utf-8?B?ZXFnOENwR05oYzIzZzV0MFpETjFHOE9jbEdkMjRXNWYrRnhLV0hydktvdnNo?=
 =?utf-8?B?dVE4S2U5NFZkT1o4UWM3ZzJUcFBmdXE4ZDZ2L2hzMjZzNzgyUmx2VzN0TnJl?=
 =?utf-8?B?QU9jU3JTam1CS2hUOEtSY0JKeTA3d3NHSWNKRUhWOWpwWUc5Yk0xMDZLbGlV?=
 =?utf-8?B?dUFDNjU3VEtOaEEvQVJCVlhyWnZsU0pCYzdUZ1FzVEhtR0tvWlBUaFdFekQw?=
 =?utf-8?B?bm1ZekRucVFSSTBUZitEYVVOeXo5bmNyR1kyS0FDYTJJaVFzU1Bld1JRRnMw?=
 =?utf-8?B?MUIzWDErZ1BwM3VmQUhHRU50KzBzdm5iSXBHQUpvZDNleUdNREp6SFd0RmFr?=
 =?utf-8?B?eUFPWW1iSURVbWJYd0NqR1VPZk1rdTdCQjFyNkMvN0g2eWRWVFdaVWRJekl6?=
 =?utf-8?B?Q3A5cktrekdzM0Z1clVTUzAzUEdaUlpBWmtHK0RZV000ZkRuTTlZK1N6Z1Bh?=
 =?utf-8?B?V3ZzOGVMUTZhd3N3NnNpUktPWE5GeGtVTTJlVENNQUovcUhWcnJ1OFcvbWhL?=
 =?utf-8?B?MXJITXJQV2hGK1BLaFIrei8reFFaT2ErT0Q1S1lJSlJCSUJ3bDJqS0kzRTJZ?=
 =?utf-8?B?a2xhdmlkNHc3UnNDNDIrZnV1NXJseUNOL2Yzd05KcFluQ3lWb0FSQUZZeldV?=
 =?utf-8?B?NElteXFsYzRGQ0dKYThEWERSaTRwc2xxYkx4WnYxdE1EN0t2YXpUUm5MeUxO?=
 =?utf-8?B?T0ZsaUpsSWloVUc4OW1SOVFMSUVPTElRMjFaWGU2Vm9lU01paTB2ZlZyNWZ5?=
 =?utf-8?B?YkN4S0xaZllLcmpzbWR2L0NHdGxXU0EwQmZBYkt2c3Q5eDRNRmdva0xHU1l3?=
 =?utf-8?B?dytkUVRtOWRydmx0d3hVeTl4dEFBTWFOOGRzZXNUTnQ2c09ZeWhQQjlWUi9q?=
 =?utf-8?B?OHBaRDgvV2I3R3JFbjFYdUVpc3kvNmZBZWFGQjVwd3BBNVBma3EyYnE3NDQ3?=
 =?utf-8?B?RGZQcEk0Q2ZCcjVETE82aWZIbEZDNXQ3emw2NjM2TlJFc1FjcGlrdzdIWTZN?=
 =?utf-8?B?WTJaeHhmeDRmdWoyWmVBRnE5djdXbnNKaVZXVmx0ckJvSCtwT1VSTWtWTFRw?=
 =?utf-8?B?Y01OZ3BFWXUvVUNUR0RKVktjcTUrbzczS3FWdEVWRnVrNmlIU3lyTGxrMFhD?=
 =?utf-8?B?MDlaUWhDdXFTRjIydUd2cVRhOTRZV0liZCtXYisxczdEUjNBMUdoNThhSEtk?=
 =?utf-8?B?bDFvSnZ0Smh0Y0FPLzVmU2w3UXJvZjQwaHpGYkNzQTU2TlJLcHVMeEpjSkdq?=
 =?utf-8?B?UWVENXpuWFNPaFJ3U3BzZXk3bmRweW15MHRPY3VvZ0Y4WFpBc2ErMGpzQUdJ?=
 =?utf-8?B?SmpyeEZ5amtBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkI5WTNhSGpRN0xrTzhnQlhQS1BPNWc5K0x0UU5rNURDWW14Y1MvK3pOS3Zx?=
 =?utf-8?B?alFUNWltNXNsOHpKQnVKWm0xUkthOStHKzZyR3FQSXpkQ0tPOFBOQnlVelo3?=
 =?utf-8?B?VVZ3VTJYd3FoTkpGZytjT1RaVWN3UkhnU0lBK3JOWUhSN0pHZkVrS1hxYWQ2?=
 =?utf-8?B?UVF2UTYzY2FZU3lybng0T1dBTGZCeXpXb05kRldUVVp5S1FiREdlMy9PWk15?=
 =?utf-8?B?NFVUNkFRUkhreUppK3JwdGpYQUppZGdXTldITDUvQW5hZG1OMmpvRG5PeWxi?=
 =?utf-8?B?NldLNjY2MkltelVXUk9iOWJWTFBibDlUSy9sMmFsVFhZNkRqVGhZTFhDNFpm?=
 =?utf-8?B?Wll5dHZ6WnY2N1o1N2RnUUNoczBDWmF1VFgyOVBPQlNXWDlkQVMyYjJZWitI?=
 =?utf-8?B?QllyTWl1NVZDeU1HUXN0NmZEYmh1YWhSeTlwaEpMcWxNL3dXMzIvanVTUDFp?=
 =?utf-8?B?eDY0UDVWT1l1a1h4RzU4V2JjME95c0d6eEk0a0J1Z1BSMFR1YVVvV1k2anJE?=
 =?utf-8?B?eWVhU3Y5VXNuSlZmNGdsY3hieG1Eb3B0b0FOUG9xdmduL2dYMkRJSjdXRkdI?=
 =?utf-8?B?aW9EcU1RT0RLM1hFSzI0Y1RaaVphbHlURW1sQ1FzRWgvdklyQUl2ZGk5S3VT?=
 =?utf-8?B?U1BPUzFybXcrTWZic0lUdllrNVBvb0o4S0k3LzVMYWVJTjVnWStLVUZFM01r?=
 =?utf-8?B?WHAxTjIweFNhUW9vYmgzaWg4T01qNGRLdm9GWHNZb0VDTUpidlBxZnNQNzlS?=
 =?utf-8?B?dmUwSmxyYW1hazAwVlFwNHE1VHBVUXRHVjFtL0pNemROWkYyWGl4dGxWZyts?=
 =?utf-8?B?bFZTNnRYVUFUbU9LbDkzbkxlWVJscXlURFdlVlJkUnRzZmd6SlUxc1Z1M3Fn?=
 =?utf-8?B?V1VUTm0rRDlJaC9oWlY3eTBOQXBkd3MvZDFWZ3p0QUFHbSs3encxOHRyN3Ew?=
 =?utf-8?B?U1NBZ2hLVjRSMmZSUFJqQU52K2doWDZOc0tRWlFpQnRmOUx4aUNqSmVRQjds?=
 =?utf-8?B?Q2J2aVlDcVZ2STZRaUJRUUtWSSticU5FWUIySGMrZGVsMThNNFBucTBZV0lp?=
 =?utf-8?B?cWJ1djl4a2puODVQamhQLzROQXhQT1AxWVhIejFrQnlQUXpnUkZReG9ncC84?=
 =?utf-8?B?VGVnalNQL2ZaM1R5b2tJb0ErZExOYXQ3ZzQ4OFRRdW9nck5rZmxrZWxrV3dB?=
 =?utf-8?B?UXlSTkdDN01TbU1QMHNZTXVybjF6djhXemVVRXpUQWVIK1V0eTBDK2srbXc3?=
 =?utf-8?B?TExzY2NlRDFMajk2R21GWmdSNXRkeTlraWV5RGJJM0VoaUlUQkR2VXBQYnBl?=
 =?utf-8?B?SGcrK0xqNjhRQWI2VlNyaEtESm9tNUlRUTJmTjZEeFEreXpXN1g3MWRsV0Fh?=
 =?utf-8?B?ZnNMY092ZlNhVmFsc1hQZlJucENncHVxWVFERm16TFFOYVcxNjhRUGxEMTMw?=
 =?utf-8?B?SUcyNFJRaUJMUk4rNGx0OW51dDM0TkwxUHZ1aTY1bEt3d3RWaW0zVmpHdlZK?=
 =?utf-8?B?V3VMMkprUitaTm1CZDZYUDdGSU9GNXJiUTZKY1RNVFBOakZPY2drRFZiOXBR?=
 =?utf-8?B?dnU4TlJqNTdTV3A3RHJ4MWxjL3dJNTBjSFdhOG1GV0hGb0tPTjdGVkN1RG03?=
 =?utf-8?B?NDdzUTBIc3g5VGhUSG4zakNiQjQxY2NFL3FEZDF3T2F1cVNMWHF1RVl6NCtL?=
 =?utf-8?B?OHJHUUl0Z0VuQ0x5enlYZTlaTnZIR2tYbzlGMnVhYWVkTFVKN3lpRFdWWGI4?=
 =?utf-8?B?UUYxd1VjMk5obUJGZ1ZDaFcvZU9Ka2hIZGRIZFNPeTRYVjJEUzA3b1JCelRw?=
 =?utf-8?B?OFZQVVV3aXRBaEc5dTkxQytHeEYycGJzRVFOTE1oRFBKaTNQdnpPeUFsdk9x?=
 =?utf-8?B?QTBqS3Bnc2RmSk1wV3JvdFBFM3hHVWVJUTRZK1I5UE12OWxteERxUTBUc2lM?=
 =?utf-8?B?TktmTXBiTEoxaytVYVFJbFg0WGMwa2xHRHJFUXB2emZUeDlIYWxYOHJYVHhM?=
 =?utf-8?B?OVdVL1UrTXdOYkdqV1B4TkdWYVlYK043UjZuMGxYT3pkT0U5eUtZMFRqWGJY?=
 =?utf-8?B?ZUk1YmwrNnJNQWtzVnhyUk1uYXZLb3Nhd09pRFNzS0ZZZWl6TE0zVzdHMGU3?=
 =?utf-8?B?d0RDcklDeUZVck02Um1TZ1R5bUJmblBtbzZXK2tyRUUrUmx4TCtUL0psVXhw?=
 =?utf-8?Q?fPn8BJg4t4Tib89t6v/7s/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A493AAEABD3CA6419FA143889041E830@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a729d19f-c4a4-43b0-1277-08dd7d1b0ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 19:15:25.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXsYum1Q0IE+aQ6F7XZcI2tE11bezRFy1a9YRTVhyGRLk80IpQjngdrD2TvBxQZNxT4dWAos8Zzz8TiEXS8Kuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF99570C442
X-Proofpoint-GUID: 5TEVqyR9DAzCVSA6lHPhbC8E0Pt_2YjX
X-Authority-Analysis: v=2.4 cv=UuxjN/wB c=1 sm=1 tr=0 ts=680001d2 cx=c_pps a=CZyBIZNk7+VlD+/eRBofeA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=X5L3JeaEOlXc4u4ZOdwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 5TEVqyR9DAzCVSA6lHPhbC8E0Pt_2YjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_07,2025-04-15_01,2024-11-22_01

DQoNCj4gT24gQXByIDksIDIwMjUsIGF0IDEyOjU34oCvQU0sIFNhbmRpcGFuIERhcyA8c2FuZGlw
YW4uZGFzQGFtZC5jb20+IHdyb3RlOg0KPiANCj4gVW5saWtlIEwzIGFuZCBERiBjb3VudGVycywg
VU1DIGNvdW50ZXJzIChQRVJGX0NUUnMpIHNldCB0aGUgT3ZlcmZsb3cgYml0DQo+IChiaXQgNDgp
IGFuZCBzYXR1cmF0ZSBvbiBvdmVyZmxvdy4gQSBzdWJzZXF1ZW50IHBtdS0+cmVhZCgpIG9mIHRo
ZSBldmVudA0KPiByZXBvcnRzIGFuIGluY29ycmVjdCBhY2N1bXVsYXRlZCBjb3VudCBhcyB0aGVy
ZSBpcyBubyBkaWZmZXJlbmNlIGJldHdlZW4NCj4gdGhlIHByZXZpb3VzIGFuZCB0aGUgY3VycmVu
dCB2YWx1ZXMgb2YgdGhlIGNvdW50ZXIuDQo+IA0KPiBUbyBhdm9pZCB0aGlzLCBpbnNwZWN0IHRo
ZSBjdXJyZW50IGNvdW50ZXIgdmFsdWUgYW5kIHByb2FjdGl2ZWx5IHJlc2V0DQo+IHRoZSBjb3Jy
ZXNwb25kaW5nIFBFUkZfQ1RSIHJlZ2lzdGVyIG9uIGV2ZXJ5IHBtdS0+cmVhZCgpLiBDb21iaW5l
ZCB3aXRoDQo+IHRoZSBwZXJpb2RpYyByZWFkcyBpbml0aWF0ZWQgYnkgdGhlIGhydGltZXIsIHRo
ZSBjb3VudGVycyBuZXZlciBnZXQgYQ0KPiBjaGFuY2Ugc2F0dXJhdGUgYnV0IHRoZSByZXNvbHV0
aW9uIHJlZHVjZXMgdG8gNDcgYml0cy4NCj4gDQo+IEZpeGVzOiAyNWU1Njg0NzgyMWYgKCJwZXJm
L3g4Ni9hbWQvdW5jb3JlOiBBZGQgbWVtb3J5IGNvbnRyb2xsZXIgc3VwcG9ydCIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFNhbmRpcGFuIERhcyA8c2FuZGlwYW4uZGFzQGFtZC5jb20+DQoNClJldmlld2Vk
LWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KDQpUaGFua3MgZm9yIHRoZSBmaXghDQoN
Cg0KDQo=
