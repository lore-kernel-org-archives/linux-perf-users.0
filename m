Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95E16F856;
	Tue, 28 May 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890174; cv=fail; b=l5zUd4NvCBuWhOuec3m+xN7sKKy1SaAMOriJz4NV4Wr/d9ClvMcUeTc3igbgbq26pYIOrYzapNyuoPngFNfQT+AVvmza0Hkhab4OM5Sk8GqrKV5qFjjV0FAIVZaVj724T5X/9DzYOp62t9oaGn1scqYsMF1XKkPN1cl2cOffV4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890174; c=relaxed/simple;
	bh=9za4wgxrllEkneZXsAzTL6myc6vBc5jFctGPodWBpEw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UWlVw09HfLMh7KQ/JV9oJOvWqLIdQlMKWTtHIVbCKBDH054XnDBViqj5v/Nspr4vaew/8Uej2IrBYOJeWmJEde4QufSUlgJWLlFMh3O35g+JUzIxEtydg2CGLrIzEPoYnmPzcqDbAJd8hdx22k58NYuJpXukbKz6+FKKkD99Olw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44S7wqWw002784;
	Tue, 28 May 2024 09:55:33 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcontent-transfer-encoding:content-type:date:from:in-reply-to?=
 =?UTF-8?Q?:message-id:mime-version:references:subject:to;_s=3Dcorp-2023-1?=
 =?UTF-8?Q?1-20;_bh=3D6hjlNR8BacESIza6/03CHyRAOUDSIggbOUb9zbCXAn8=3D;_b=3D?=
 =?UTF-8?Q?LkrmsELPcngpt0hiER8Bot8sM+DtptSBofls6XE8iuU8BtCXNilC3FnxlcG9eaL?=
 =?UTF-8?Q?QxKK+_X+NqrhEai/RRLqM9Xv6y8FRjNvTbazjhnk7A2VJ9jA84XDzlcfyyGWTql?=
 =?UTF-8?Q?/gaXw21H6a7_LrqIhgK/WoYUlHPRi4ur5r+hScz3z60bH6JErgZerWWnSvGQ0wn?=
 =?UTF-8?Q?1cOlRkMBsTGVEYQD5_UIxI8qV6501h76o8nUvP3iUt7dl/rzk+eOy7FqEvs4ykI?=
 =?UTF-8?Q?3UBBTMqp8mcRUTC8Qy52paE_pOPSBLGTQ9PS6u6HXOS4yYFjeeg7iIOSqdNyZp9?=
 =?UTF-8?Q?DvK7KUee646HY1SBRLSuHQvOpuFcL_Lw=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9kyx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 09:55:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44S7aUmH025792;
	Tue, 28 May 2024 09:55:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50pmk49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 09:55:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj3eODGM8FcU3x37AKm63CUIovkpP0kdjk4sPGR7d+DQ8AIcqi60gDLtO6y+LXfhIB6MWFPhWQMkIAcSXRd2ZfdHkTh+D3GAFTe1qclYSMAx6Tkiw4OROq28eIZYutud2oi3AempSNe6Ja0/i/v1z4R+fc7BvqduYzKv84KlbjNbMHY1eXefwOnHENg+7ugzgCFEbTkGSy4TatXaXZT0NbkCJr6rrfC6ZbRr9Ulzp7Eld/BmvCCB7pdilHH8fJSuki5ewpFNjojewTPebH1XEkUFUDQPcG1Qsb6PqD0gBeLgzf34y7eIXbsSBDEV3LZLWEKtc+INQvnXEIjf9sf69Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hjlNR8BacESIza6/03CHyRAOUDSIggbOUb9zbCXAn8=;
 b=Js3V/q9zScrv5D7mVRXxB/RSxfBz7bL6QVlSQ78JRk5sES6mEM8KSW+XdR4Ahh24d1f/RFnAAjamu63HpQYn7aSJWxw3EkpxhOZ98co2h9wKKhmxymHs/OstF20QnB1rcM6Xjl4Y1haXO5ilThu0II/CipETLEe/0GxZHl1rMB/etrDluer5i05+NTYVHFxgNNI7g8Xz5SAhBtg0XMhmsYY3JGGNXqKwzfQGIH3oAJdl7sHQwuuj70TG6bXXCR8AKf1AGkDEtMeChDQjXjAk0D+EkGs723ImkdmX8eiWHX3YVlZ4OBv1Nl43h4cRofddAyMmqH9FW/Oe6lVByy56Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hjlNR8BacESIza6/03CHyRAOUDSIggbOUb9zbCXAn8=;
 b=jdUU+ZjU9P5VISKHpZMO3lgKxQXCbKdTEmfD1G3eEzKAaefB7JUGcVMSzwtYh5oGc1ekdbYcSSVZXg31JVpsVO4QcbIdxPbdouf8I0VGTDo7i8vVZfVb0X4eyMl75BHXxZ3cyP7lAVmYbMpxJT+2Y8zAe51s9NmDGvN6Od5WQwI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6880.namprd10.prod.outlook.com (2603:10b6:208:420::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Tue, 28 May
 2024 09:55:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:55:29 +0000
Message-ID: <4b825fe5-c787-4e10-b771-536b6370311c@oracle.com>
Date: Tue, 28 May 2024 10:55:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf jevents: Use name for special find value
To: Ian Rogers <irogers@google.com>, Weilin Wang <weilin.wang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sandipan Das
 <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240525013021.436430-1-irogers@google.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240525013021.436430-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b10740-3898-4a7b-dccd-08dc7efc4e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|7416005|376005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dUxQNk5YV0N5OGtnanNaQlkxVHNzL1JqazhRV0pOdkkzd01DM0k4RlNuVHY3?=
 =?utf-8?B?N2tyYXc4NVpLUStNZExqV000b1RIcHR2RXpWTGphdGRTUjBxejN3cEwwclgv?=
 =?utf-8?B?R01WcXdnSEVERk9ydm9nYzIxNWFwSmErZUlyREZTUlpBL0lZUmhKanhDK000?=
 =?utf-8?B?TTBSS0dzbzg2VW5jaVhHQVpnKzB3RE96bU9jZDJzR25CdjhFdEFjeDFFdGFH?=
 =?utf-8?B?N0xNd0cvQnlHZUtON1pyejcvajVzZG1VQnlHeldJRDVTY0x3a0VOY1IzMWc0?=
 =?utf-8?B?V085SlJuaklIcGhKamkxSUwrdms5dldLMjFOczhReG9XWDQ0ZVNzcWNvbmg5?=
 =?utf-8?B?UWxIQ0NLUEtZRHB0c3pZTEFUQ3FEUWMrMk9nTG9ZM0xNWitrOERja3YrbFNx?=
 =?utf-8?B?M3FJSkJ3TEU5QllHb1FGRVZRSWVVU3NmcmpNTjZvcVBwUVpFVzhXaXE0dXZj?=
 =?utf-8?B?bmNGV2RNN1hxTDFTeEJKRTFhaTU3VXJHcUNicmhBSnlaU0gva0VYYXZ1R25X?=
 =?utf-8?B?Y3YxL0diZmFWT0E1MjFjOHJ2WkxnQ2s4czJZdmtMNVVZVkJOREdJWjBGZXJx?=
 =?utf-8?B?dzZKa0kzTWR6ZTBHbVZqcW5HK2Fkb0tiL0hnZUMyVVpjREdtSjEwOWkvLy84?=
 =?utf-8?B?b0t3cGIzd3lHTExLTXFsdVpWTnFqbEFiNG9zNDJ1WlZmTHZGb3VtZk1Ndlg1?=
 =?utf-8?B?TDVrM0p4S3Z3WG1tY2t6MHJ4MnVNQTVEL1Qrd1piemU4cUx3cFFUR1piKzF4?=
 =?utf-8?B?OVJ2eFg3MlYrQ1c3MGErbjIvRnJ1UDlqamRwMFZUWjFwa09rMStiU3loWUVw?=
 =?utf-8?B?OEo3OGgwQ1lLWnJnekY1RDM0YmdiNkcrbHhTOTE4YktzQUFGejBHOXhvdUJO?=
 =?utf-8?B?Zm5qZ29aRnlBNTdzZGw0R1VHM2M4ZkxyU3BqQ01UeW9kaHVhaC9aWUp5WjZj?=
 =?utf-8?B?RXRkR1kyU2ZTdGR3VEdWcTNhajFpQ2R2OEdRVUtRRmtQeHF4MUJ1ZXZQdWNh?=
 =?utf-8?B?RC80ZzMreXJEaHBIQjhGdnFsT2VUMnFJR2pvVWNnd0dDQTVnUjdWMm1Sa1pv?=
 =?utf-8?B?ZFRzWWdOY3I5WEJ0VjBVdWgxZyt5UE5HMWdsanB2WllTRUl6ZG9LRkh3K080?=
 =?utf-8?B?bGpnU3hZdFNpV2FOZk1JTk5VMmRkdmczMHk2NVNjN1E1OGZxblIzeWlGTWZX?=
 =?utf-8?B?cnZWNVpvdlpaT2xRb0FrK0JhSUo2Wmoyb2JOVGJQVi9SM3NqeHJFRTVBWXNX?=
 =?utf-8?B?V0hGRm9VRE1RVHZWODRPVXBySm1FcVY2QXZ5NyttODUweUxMaU4yVW5UZ0JL?=
 =?utf-8?B?VXBDbGRyWUozT0JXRzRjY3FKOXRCQXVoK1NLd0x2dEp6NGlpWE5aTHpqcnk5?=
 =?utf-8?B?LzE5ZUxyWVhtZjhQdytNbUJYZ2dldXFWcjk0ZFJMbXIyR1VadEZLd3hlWk8r?=
 =?utf-8?B?WkhvZ3c0enl5dk13M0JScUhkM1RrOUU0UU14UUFNbm5IVFpKMDBUdUlXRDZi?=
 =?utf-8?B?Y0s0Uk9BRlZRbnlVLzRZd2g4SWNNRnliQTFnaVhXQVdKM08vT1IwQncrQ1VT?=
 =?utf-8?B?V2x6Rk16Unp4dTVXWllVM2pNVG1kOGJQalVQbTUyY1VwTCtYSERMVHVPWEpG?=
 =?utf-8?B?MEovcFUveDhudjdTWlpzTWdCa2xkOTd0TzhOT1BrWWEycFRJUXFzcmhjcWo5?=
 =?utf-8?B?dSswbml0UnJrUUFQTUtvTG1Kc3B1dUJOTmswNUJ2YjZVNUZ6Ui9UNHptSlln?=
 =?utf-8?Q?rjMc7Ycx4OzJ+upb0UQ+XxNstTu0EqkFrkxOoM8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHFBYVkxV004c3RWUVplM3M3bm92VVFmR21PWEhwQTNJSC92RzhSenJ4d3Y4?=
 =?utf-8?B?dzN0eUk1bW1Wb2pqN3pWcnppQ25XT2hRZExwaHJFS2FsYmp0dEE4Y2RFR1BK?=
 =?utf-8?B?bUU4SWxUQmVQK05KOGJMNUR6SjM5ZlNVajVxZVRnb1BEZ2FVRWp1VGRpTHVI?=
 =?utf-8?B?b0lSTWdCNy9ScnFuM2RSMUxWd0pLaXJaQ2RVQXFzNWg1QjdCTXlnVklZVXhx?=
 =?utf-8?B?UnF4TWZsa3VWZHMxOXNNWjY2cGdCaVByYjBJaEQvM2VqOUREMUR0SlJPMXpD?=
 =?utf-8?B?YUxUVkNlRHkyMTV1M3BGazk3bnNFNmVoNDd1enV1NXNzZGM5OGdkOStMWCt4?=
 =?utf-8?B?clgrOTlYRnZUelZ0aGd2VVlLbFZRYWhHdHJJNmF3Vlg3b3M3WDl0NUxweHVr?=
 =?utf-8?B?TDFwcW5mMDB5SG8rZnY5eElUV0R3Z3lMcWZ5RzhCRDhHUkVSb2hsUy9JejJO?=
 =?utf-8?B?YjJnRHJqUHllSmRXRVlTV0d1UXczclVkQzlCdGk3VHlOQ3dGT2hMVWN6eUhs?=
 =?utf-8?B?dHgyMVFsN2ticGszYXU5Z2YzcDEwaGQ4OVlCVXV5STN1SFYwQU1ycGlKVUZm?=
 =?utf-8?B?bTJENlRRRVRyQk5Rdk50aCt3OVNSOUw5MFl6ZnhuSEVXbnpyZ0YzZ2NZM3g1?=
 =?utf-8?B?U1NrVUFKRHdwNlQvQlZzVlBrdVdSL0VPWFBXejNDMWN3OHpFbHZmSjArVExE?=
 =?utf-8?B?UENRaUVhMUZzUjNVN1lJdnRVdE1KV1FYVmtYL3hCV3ZqY1EzMjRzellhNkZN?=
 =?utf-8?B?ekNlZitNUzhOazQ5bFVWbkdBY3BRSkRNRzI2M2F0emZkVDdYU0FSUVFJdGZB?=
 =?utf-8?B?Q3ROUVN6N1pwejZkUEtpY3RyZGg1SWJoWE5NcmR3ZzZ3TXFuZURFU01hWVBp?=
 =?utf-8?B?K2NsNFZSVmV4cHZjamFKL2dhaE5obldPWWNBanVGY1cxV2plN1hBM1FuNFdN?=
 =?utf-8?B?NXJzemlocUdqbVJXdEgxWUpQYU5HNzRSLzdpc0hkZHZuQ2k5YlZRcFFXQzc0?=
 =?utf-8?B?VTlXNjRkYVpJc1ZmL0Vaanl3VDBuOVJuK1JTUis4MjI2Wk5oMDB0YjlUVXhZ?=
 =?utf-8?B?cXVYQjhGYjIrZzh1dzY3cnk4K0FEVW40azFTRTE3QnNtZ1ZPRFFHV2ZqM0Fm?=
 =?utf-8?B?aWNRUjFISmZtWDBBeDVKY3NwZ25rbFptMHZ6cXdpenZRempFRXJFZ3lZdVYw?=
 =?utf-8?B?bUpFNy9HNGJ2dFlKUlBJVVlMK0ZzSHpGL0NkQlRUQWcvWExVaTVCbVZVbWFY?=
 =?utf-8?B?Wkw0RGhSbS8zdnYzSU5lQjlaYUZwMElWbE9TTmx2bW5CUldGNFNsN1B0WHJN?=
 =?utf-8?B?cmdjeGZBMk8vcnBXOTlpQ3diYWFCQ3Q4TkNxeG5Gc0d6MElJenF6dGx3VG9q?=
 =?utf-8?B?SjBQWERDallncVVMSmhtVnJmS0V6UndkMEg4M0hiK1IzZkIzajV0K3dHQzZ6?=
 =?utf-8?B?S3RESy9DdWF6SnM1S215WGNydzNJRXg3VEw4VFNLZkJrdDJ5ZnRtdXRxWGEy?=
 =?utf-8?B?cVVHSHhucEJVZ29wbW03UzlRblJnT0cvc1JEU3I2V3ZkWE9WNHdkcEpVS0VC?=
 =?utf-8?B?WW9BSDEwSVhMRk9GUE5RdjRvc3MxWGFEYi9mWUJMbXpmTERvR1BxZEJsNTd1?=
 =?utf-8?B?YkhNSVFDYnBZMGp0NnM0KytQRzAycVhreERwNVEzbDZpV2w3d3hneURQN0Q2?=
 =?utf-8?B?V20wVHJzRUV4UEp0Mk5EVlVBbnE0OHl6MXJyaHJVN2lLWDd5R3JsTlp5RjBY?=
 =?utf-8?B?WWYyQ1prWk8yaERMT0pweGlDZ2RwcmFWengvMTVmcVJPaHVSVjVOa3dKcWs5?=
 =?utf-8?B?QmU1bmd2S29oRSsrRC9rdGhIcWNLd3h0aUhzclNWYTIybGtMYWtIZzNHQXA0?=
 =?utf-8?B?Tnd5Lytsd2dVYVoxa1BMTDNJT2pzZ3JQeThKUW0wVE1DR09TaEdPK1ZaVTZ5?=
 =?utf-8?B?b1VwbmVTSjhBUFQ0ME5VTkFpQlhoWit4T2F1L1hlL3dnQVpUem8xY2NraHkr?=
 =?utf-8?B?S1UrUHY3c20yUDZCSUI4YjJMR3hqdDVuZVEzQlpVMG1VeDFjcDFGanJuaFY5?=
 =?utf-8?B?cnh6SUhHSUtENjFDcjhpcUZ4OXpwL1Evcm9RUFBvOHVJMUFIVU5sS3dOQTNz?=
 =?utf-8?B?a0Y5Wnp4YUNWWU5FbE9hYVpUb21tNkZDd2dLVVlEbzdJbmVMa25vOHJRN1lF?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NUeFn5B9tlA5l/XEhG0pL7BSbYgmrs/bA4DiMRz5RCT6kf5Vpmn5vAdJ9bunL+BFt7KvDyKGxhy567znuw2i6Jq3GTHMN51OpQd37lx2ne4GPRPNTpBrsSjAOZXraeSyz6cspzbMyafWzhRwG3uy62kfd2uyXExSMYqotpcttV+Q+1Bws58+EOhiomXASa88RF9ACe9qQm/A0d0k8CJW0eDK5dXtPpwnpqM+o4O8xHC9NsANzQq4OeWvPfok3KhPekV+jhiQN/1ay5aogx/p/zunig8RlM5xDAvZFgPK9T5Ga952WEpU/KKCsxdqIFwGOoAYHal+UUbdxlgq3e10t/NmrwHPJF62i7ne3nTUoCUz/gBQIWC2cqxXQfOrkgIdXcm05Xxftgz+A/RZoUPCmkjmNPLtm8VzhWzriUiqc0hEMCmbJ8zvzeKHVtlbezxb0PbxIMl8+cB8Od6ieSU3+JYWlDouxeFYdIfNDEOMf9RRxtpUyVIiovl4EA35CsoVRbInZUeKp7mSuxN7ghtt9+Vw/nJg5VOUteOIXIbjQZdrCSpEthxZHxAV7sMXsTZ3A5+FRpVk1l9uAL21PHn12ygksR0VRSIC8xh54rmqQXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b10740-3898-4a7b-dccd-08dc7efc4e5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 09:55:29.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrWfrkSYIT4JU2gaOnhKl2x2dfelg6jycLK7XCa3X2mUQkau1Y0xNBJioahzPHgtMPKaPKnfdxMNmTMEQpYwlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_05,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280073
X-Proofpoint-GUID: UT3CheZFUTho6X4415JdDiq03fKv-nM3
X-Proofpoint-ORIG-GUID: UT3CheZFUTho6X4415JdDiq03fKv-nM3

On 25/05/2024 02:30, Ian Rogers wrote:
> -1000 was used as a special value added in Commit 3d5045492ab2 ("perf
> pmu-events: Add pmu_events_table__find_event()") to show that 1 table
> lacked a PMU/event but that didn't terminate the search in other
> tables. Add a new constant PMU_EVENTS__NOT_FOUND for this value and
> use it.
> 
> Signed-off-by: Ian Rogers<irogers@google.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
