Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D717BD5;
	Thu, 26 Sep 2024 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727323527; cv=fail; b=DbA7FIPgzsPUqd4lp3xbmlXx6bI0N4TGIGSrIVjL1I49GUCigtzkTD4E/RI2wkRpgRSt33BXf4JxVOr6N+3N7a5naHR3QzJIIq/A8gQJT/UKwnApMEW5KualD3FL8zbzs141lTNnfit7LF9k65lVl8KCk55IyLAGS8tXNhEXU4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727323527; c=relaxed/simple;
	bh=zWpMWhVTZ9w1jlwRwhNoHS8284zy3WIsj/o+VO8FTqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IoZ63RPrxSiNT+e31tDV+sWNEQD9Y12o5myp6PfQVqbl+1GWDfWxIWxfNT5rEEPN9G7X4lH8MNP8J7gvwHZv6Lv32uPCO2e/MFFz03JtDcsDmXSyAIp9499dITUPbtdfv9Bu1ZGhBHh2ilITBLPPMRQd6jw3YQrK2aS++YlIeDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZnysEjeE; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZnysEjeE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgZxSj6XEyMLqWRMN4FOzHUXApCNb/9rxHktXgmWqCU8bAHMABoOCGFSrKBj4OVlZ+S5u3pl09zYn+l73gYanYhrqb4C/oeh50bRiDP1xCvuz0ouExaXJkslyHzjFJOrJUErqCMdJYSZmA9cEOwFkhr4xv1oNWONW5Lmag/up+Jb9Fu1Ei/JaXxxx/RGibsC9cYngYgPsB83i6aiSOabjSdsuWVnq/OHU5Lbgk/pwW+1zgDU8i4ROu04xNAhirS6v0MLxeP7vbt7OObzAbt8qw5bo1W/KfHpnC31g+zh8pibS12/CVzacpSEC2SWD58tWBcZKcuHlk/zHmSw77iQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gew14EOdXte1lOnvuuLbZ+UdNe+dvpVrsIJs4K9f4jw=;
 b=wnzBYjbxfF4BFNBTKAhVeAI4B/FFT0PEcA0NNVfs4FUe6lDoq8YibOxk9mEo2yf6nMcKLHJYxKm++GGDgFNBCvIcwYrA/BN1ZvweA+tRt1xdh0HDxhtILc+tvnW7Fuy1uwkvUncxetMXQfOkL0AnND+Tv4obSRCMOK4VdkdWTpN+5/8rblSlGBG8Y5jwwLvNHrcn07JfLjJVzwUHD3frPGX8asNhhOe25DI5VoHP4Brm4XYiQU3g/J4PryUs5a/Qd9JLu2azjuVjgoIZcIO7k3htc9V+iLxT91SszRD5j0JgeCSmixsURdsc7bUVCPs1wbvAbg1GmPsBkLOGbniDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gew14EOdXte1lOnvuuLbZ+UdNe+dvpVrsIJs4K9f4jw=;
 b=ZnysEjeEW5G+R/TploTdu7qPI323L7fT5h7fVnaca61lcm1fbBbodQpd8Tb4hV3x4liAA/zwcHG5I9ppMy0Hl2133IgGX7us94SuXFiLMW8ga1xLOgKEsupohD0vDs0Rk/BhP2Qc5b+aIS5RERiChprVayE+0AoFK6WM5HjwEI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Thu, 26 Sep
 2024 04:05:23 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 04:05:23 +0000
Message-ID: <580484ba-88d0-4f69-a52c-d078e04c67fe@amd.com>
Date: Thu, 26 Sep 2024 09:35:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: George Kennedy <george.kennedy@oracle.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dongli Zhang <dongli.zhang@oracle.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
 <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
 <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
 <78db946d-db24-408e-92fc-b7ff79c80728@amd.com>
 <e193949b-d969-42e7-a0f3-fbea6e4dfe12@oracle.com>
 <7a34a58b-9366-46a4-92ca-e36e378311f5@amd.com>
 <5a8e73b5-7bb8-4669-a255-808abd2d2132@oracle.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <5a8e73b5-7bb8-4669-a255-808abd2d2132@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::28) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 65df21e1-e899-458c-99f6-08dcdde071da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVBBcEp0UWtnWFBKZjdnMmtVRUpNSFBHUDh2V0lVdW9rQzNFYUMxczJiR1Y1?=
 =?utf-8?B?WFdGNVRMQ3gyR0dyTnpWUytnbjlmU3o1QXNGUnZGbUNiM1RNWHYzMFIwSGdI?=
 =?utf-8?B?c1NoQlRrdjlxV25hYzVhMmE2aUtXdERlSTYrTjJsVHpXTWw4MVg1UXdYaEtL?=
 =?utf-8?B?Z1JTazhCOC9mVnZWdUVkUWtYSlh2Wml2UnBpbE05eGJKb25CQ21WdnFSZ2xs?=
 =?utf-8?B?S2VUUWE4TXVVWVVyZ1I1NG9sV3VweGFadjAvQmZ3bzFoOStuTFp6VkhUa1kv?=
 =?utf-8?B?bTQreEhZRWtUM3Vva1NDb3NPQjloVTdqZnN5Z1lSQXVrVTBQSTdpem5QcFVl?=
 =?utf-8?B?emM1OW0xVEZDcy9VczY1Uk5xWnZuZzBpVHZtL3ZreEduemdsSUMwWk1sVWZ2?=
 =?utf-8?B?eXNzNWl6dWVYQjZ4bzRGZDFGT3VVRkhvYXBQa2JGYnlUSGx2NUczTzlzOUl0?=
 =?utf-8?B?SlhRS3BibVZ1dGFFM3lsZUJiZFdGbTVIbXg2M3VLczR6USsxUi9ML3hMVmRW?=
 =?utf-8?B?MlY3ZlhkeEYybVdFU1NVMVNDOE5PWXpKK0JDRG1DRFNHOE1oV0Q3dzMxTDN0?=
 =?utf-8?B?WlJiTThOQkhaSDNNWVZjUVhKNnpxdy9xbnNhOHlwY3lEQWtkaThLY1ZtV2Rl?=
 =?utf-8?B?S3NZeVhScmd3VDJ1WVdXUXZEUE5qbThwQ3RJWkEwQ25Uakg1K1EyOVpicElL?=
 =?utf-8?B?alQ2ck5YS24vYTNwbUJEKzVrc3ZNaG14bmRFQUhiWnlWb29hVFZ2YTh4VldS?=
 =?utf-8?B?SHFOdHFDMEZmMkhlNG45NmlsYmcyeE9MZDJRSTJHaTlIdkxEaDRNLzlpQ1lW?=
 =?utf-8?B?WEtVc21UZHJNdEt6MGIvTXk3OVc2dkNFTXdZQ2NWbmJGZG5uYzZKWjJZNUx1?=
 =?utf-8?B?ZHFVYSt3MUtzWXQ5SEk1bFJ0QXNlVXlXTjZxZnY5S2pBUGtUZjFJazl5OXJz?=
 =?utf-8?B?d0gySHpib3hsSGg3L0N5RitHMExHaTVtalNid0tGRnpOM1VpU2htUUNVN1Vz?=
 =?utf-8?B?bVAwTEhEWGFZcFJ0aWs5WjJrdVhTd05lc3phektsY1R3M1ZaeFQxRmx5MnZZ?=
 =?utf-8?B?Z3FhK3FNNzRtak53S0ZSaEYzanhlRWl1ZGxEVzI2N0N3eFFTUTZzWW84RHZ1?=
 =?utf-8?B?TDZmc3NjVU5kMkNtbVV6UDdtbHVaQlhuaWRXakcwSzRrTjRiRFlKbGdZVTBP?=
 =?utf-8?B?ZnJOSVZUQmNPcm0zYXdMSC9lMkRvRmMzcW41M2JHRU1OdE1BWElkSkVSQkRE?=
 =?utf-8?B?U0JtN0xyZHppNUZSZ2FCaUt3MmlqV2dXUEVCS0ZIV2huazdoY2Q3V0wxRkly?=
 =?utf-8?B?UXhkU0EzYml5b1dqUGpzWXJBaTMrNk1TWkZsR3YzaDgzZ3F5ZXBrWlBOSW9v?=
 =?utf-8?B?djlkSzd5bmJTN2F5dGJSZXBTNk91M1hjSlArSk5JSkVmWWJtSUpBeHV2SHdC?=
 =?utf-8?B?YkZQRXR4RFRrVmtHelZ0YkFrdldKWEYyNk5oeTFweWFScVc5L0dxYUpvQm1o?=
 =?utf-8?B?bDJTbFQ4Nk5YNHdPNHdmeXlNQ3B3WGF1aElLSmFuSUxwQi95R0lhaDZCZnJL?=
 =?utf-8?B?dU1WRCtuRFdZY1UxS3NTNE1SUGM5YVpxaG5CYnBpZjBoYU1lOGs0dGs4ZjlG?=
 =?utf-8?Q?5ucBIMPvtnT+XV91kaLcu6ayf/NrMOZ20NMxIC7AIJEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDRVLzdKY0FnSnJkakhzUWQzVzhlTWR6MzhDRFN5dk9XcUhPNU84VS9DbFhG?=
 =?utf-8?B?eUZDeE55T1pRS29BWkhqZ2pLNnlpY3lJZHN0TmFleUtiSDc1QmhEdGtKeVNq?=
 =?utf-8?B?K2x4Z2NjWHQwY3h1dXY2Rng5SlBGZ1NKQk1oSE9pYmRyclRNeWJIcnU4VG9w?=
 =?utf-8?B?VFhMTTJKbm12YmRHVUFHQjZMUjgzMkNzcGYyUkhuQVZKM1lXQWpuMzFyT1lL?=
 =?utf-8?B?MWo1d094K3l0VUJ1bTJTMFdlZ3FYekFoamY4WmZmRVBsZGpQRU4rRTlibGFa?=
 =?utf-8?B?OWIwWjdGRzA5SmNIZUtjS1kvRk5XYjhSV2djMmt1S3VHVUE1RGdHdW5jYTlS?=
 =?utf-8?B?UUIxRTYveVgveTNmZS9aZmlKODJKM1VybTJZSGFCWDFuTkZ6RU8xa1E1WGMz?=
 =?utf-8?B?akNxcWdsekFKSFFRVWo2MlhObm5vZDk3YWI2ZjcwZmtSa3ZFTzYvUVFSa3dL?=
 =?utf-8?B?U3pvMU5IckgzWEp2U3hpV25aN3VoVkQ4elBHRTlnNG53L3llOFVKNGZNTld2?=
 =?utf-8?B?dEFqaHJDUm1mYldiQUp3UXNPMTZrOVRUVWM4Z1U4UEwzTDFwRjFINjkvTHRr?=
 =?utf-8?B?S2Z4WklzYzJkZGY3RjI5Qno4QUI0OTg4TXgrYWYwNTdHWkJsdTZqV0FhY2Rz?=
 =?utf-8?B?SENqbE10MDl3MlBZMmowTG5XTm9rNFBQU3RubGNmRHFNNGoyYUZxZVBtaGVG?=
 =?utf-8?B?dElBM2lVb1VNTGVOT3RLeis4cXY0ZXh6MVZoei9zMElqZ3VobU82a01MVXZj?=
 =?utf-8?B?Y05icnhBamlEKzFOTjRCcVg1aHVyNndPTms4Qk1uOTZyWlZOZk8xclc2aEJV?=
 =?utf-8?B?b3BIc2N1OW9EOWNySmhOV0NlUHhkMlcxcE5OaVdvZ1E2eU1UODNVYjVoNVY4?=
 =?utf-8?B?Y2Zzb3NGZisvYVFjbUloblYySU04Z1RaYkgzVlBDSlV1MklHa0t6ZWsweVJp?=
 =?utf-8?B?aCtnNCt5dTdXTysrek93UlJyTnBMNkl6Nk5iY3BTeDlCZmZURnJ4M0JNTnFL?=
 =?utf-8?B?UWdLLzh0SW1USWphczhyUnFRTDU4RnhyRGJlMUltTUpJV1hKMWhMM0ppbnpH?=
 =?utf-8?B?NjJZSDFlVndvNDdCUlhWZStLb0V3S1FmdnByVUlNSDAwbFpqcVVReTdEWktr?=
 =?utf-8?B?ZGtmcU9lRCt5Y2FUMWFCSzExUzNJQnJ5alBBb3c0QXhDVUYvcWtabDVIeUZ1?=
 =?utf-8?B?TUVNTTFzYXhOZHBFR3U0T0NhQjZ6Y0VIZEFGcENJNGpYV3VISjhhVTJJelFp?=
 =?utf-8?B?cEVWUlFGN3MySm5BSkc0d3o1VHNsV0UrV2dPbFEwNVF3M1c1VWlzRzZpM3Jj?=
 =?utf-8?B?bWhYRE1zSmZXWVV3bG1VeS9SVFlXSHpVVXFlVkZtQXNEc2lrT1pRSWJSUCt1?=
 =?utf-8?B?OGU2U3VyaWNoSzcwdnFkWnBzNHNQaEh5dTFBRWc2RmIrd3dtRlFvUjI3RmJ4?=
 =?utf-8?B?SG16ZU9nZk1kVGNVVzFTdVR1OGExdURCeUVZTVhRWXRYVTI3c2x2ZVBuNkhq?=
 =?utf-8?B?c3FsTFQ0VytqL2dFRzhqRFc0bWVuNUJMVkxUaDVrdWlONE40V2ZzMExNbDVV?=
 =?utf-8?B?RUhyMU9jRDZiejhoMFlkY1FUWU9YTkpLMnJFcHQ1endwYmllS3NVR1d1M0la?=
 =?utf-8?B?VFRGQ2hZK3BSNWZUTjh2YkUwN21ydmxLcnBhRG5XUTVXMWs0VGdpUE9la1Rw?=
 =?utf-8?B?Qk9pUkdtenJtQklqRjArUHdOd1l1NUtCZXRoZW0vTXBpcmF6OUtMeFJzd2hj?=
 =?utf-8?B?ZnBTaWc5bE9ONjJqVlFZcmRWODlVbkJYeGtoSzlOcnBPZUFsM00vSUVvWHM4?=
 =?utf-8?B?bHgzL05qVkZiTjhYT1lockhOVWtPOFVFS2FZQTFZN1pGK2VvdCtoQ3BWQnVB?=
 =?utf-8?B?YWFHYW9BUDVycFBtbGhRTkpDUk5zN0FvVVdOK2RDMXhjME5COFVYV0J1azB1?=
 =?utf-8?B?cnFBaU1WQzZzUnBCT1FmZUtCNXoybWlaMi9US2JoQ2x4MXhIV0FjdGU5ZUFO?=
 =?utf-8?B?c3BFWDVkZ1NQZ05lU0hZUUdQWkxiWDFyZ2ErcnpFRzZsRzJua0lkTFdWWnJJ?=
 =?utf-8?B?YVJxRUxLU2pKMTMwd01IayswaDVhTjdCaUhLVk1xZUNheGtwMDlmSy9ibnBZ?=
 =?utf-8?Q?Kl9zTd1jT25cpv0v7j38qD1cy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65df21e1-e899-458c-99f6-08dcdde071da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:05:23.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RESVEjLSYhDqcZHJhsYQtNMzCq9fDFZLXvDpRzbtC8wL5jycMCQefowfF+FZH7voSddLH1G2Z4bMykiZYwPK/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868

On 24-Sep-24 10:43 PM, George Kennedy wrote:
> 
> 
> On 7/2/2024 12:03 AM, Ravi Bangoria wrote:
>> On 24-Jun-24 9:48 PM, George Kennedy wrote:
>>>
>>> On 6/10/2024 6:51 AM, Ravi Bangoria wrote:
>>>> On 6/8/2024 12:43 AM, George Kennedy wrote:
>>>>> Hi Ravi,
>>>>>
>>>>> On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>>>>>>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>>>>>>> Can you please also explain "how".
>>>>>>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>>>>>>>> This appears to be an AMD only issue.
>>>>>>>>>>>>
>>>>>>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>>>>>>> The Syzkaller reproducer can be found in this link:
>>>>>>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>>>>>>               if (!test_bit(idx, cpuc->active_mask))
>>>>>>>>>>>>                   continue;
>>>>>>>>>>>>       -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>>>>> +        if (cpuc->events[idx])
>>>>>>>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>>>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>>>>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>>>>>>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>>>>>>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>>>>>>> There are subtle differences between Intel and AMD pmu implementation.
>>>>>>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>>>>>>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>>>>>>>
>>>>>>>> The WARN_ON_ONCE() is important because it will warn about potential
>>>>>>>> sw bug somewhere else.
>>>>>>> We could add a similar WARN_ON_ONCE() to the proposed patch.
>>>>>> Sure, that would help in future. But for current splat, can you please
>>>>>> try to rootcause the underlying race condition?
>>>>> Were you able to reproduce the crash on the AMD machine?
>>>> I'm able to reproduce within the KVM guest. Will try to investigate further.
>>> Hi Ravi,
>>>
>>> Any new status?
>> I was able to reproduce it with passthrough pmu[1] as well on a Zen4 machine
>> where Host has PerfMonV2 support (GlobalCtrl etc) but guest do not. I've
>> debugged it at some extent and seeing some race conditions, but not working
>> on this with top priority since this requires root/CAP_PERFMON privileges to
>> cause a crash. I'll resume investigation once I get some time. Sorry about
>> the delay.
> 
> Hi Ravi,
> 
> Anything new on this issue?

Apologies for not spending time on this.

Can you please resend the patch, rebased on latest tree and a comment
stating that there is a race condition which needs to be fixed.

Something like:
  /*
   * FIXME: cpuc->events[idx] can become NULL in a subtle race
   * condition with NMI->throttle->x86_pmu_stop().
   */

I'll try to root cause and fix it properly once I get some free time.

Thanks,
Ravi
