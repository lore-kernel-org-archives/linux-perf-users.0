Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2099.outbound.protection.outlook.com [40.107.244.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1D14EC77;
	Tue,  7 May 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079790; cv=fail; b=GgkUPQnQlougBvmcwzUd5pfLZ+3k89jD4cdUf9IUxOXzzSL7NLtcI0rW2N9TU+vpWWP8lC9ZSCv4S8oDQh3543B3fhgfEXhChp6XDcJtF6HT9RC9pdCE0PnGcJFLCtrdKcnOW2Vu7ZgH6XZrPVNEBNpaB1gB9OTvgq/KDOyxNT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079790; c=relaxed/simple;
	bh=5fwPHu8mVq3bQ0WIY6rZlue3eWh9YW4WWzeZF3oW0BM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W+Qkw/1SOu21tZv/py6WHscxOX5z+ACjyXklcac12uQW03PXdUra300/iZoqt6HLiHEkzZpM4BxkQt0JAdmuxl8NAFpnArNJPM/p4B/BGSOcf3VoQHOCW0IApuLZQRGRydoCiuj8KWR4ITk7ycS+QVlpBgT/6hRsY1ZFtLjBzRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZZIerYlH; arc=fail smtp.client-ip=40.107.244.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZZIerYlH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlaYNp9nRGmoWXhWfCJNwU17kx62VZDBDDNsiXn0DXQvrBJjJlQAlCk1T7IaOIRmElftXDAxQoKtIHUoHx9KpHHoJh0BV7hGPfM4COgz07YGET16pcmh0mupED74TmwZGdkF1tpG2DEgQher9trwVlFCDy8zRpdhqDGZc/jNQVTgJLTgWyLeH0msCS05Dd3qzSVn1itRax8LIKaATtl93ig80t9VNH+8ZCyDuX+sImnrpBftY6HOew/9bEcEMmcQsSlwQfLG4PTkQZrw0pPFz3Yz+DiPhBLcfrEY3PjGQnqQowqwfK1I3E3ZAA5t0cR9/sCpiXjHgMscJlt+jcSzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtWEd1eE6KQHpSc+XY4qZSo5mNeXCeiZRHLTRHkDS8c=;
 b=KeUU+KDeLYqMQ/cnQJ81bR64nWIWTSiGlJNvyTwO4WFr02Sb2+ktLL3/ylzU6WOhcyVmbT8saRXejMebNrU6DcVHaap3VZvT2FIuLG5v1sS+NF7UlflaQeOcQgSeVsir4XoSvpZqdAgHzxd5/slRMcLwJJ+DHMrubJ4jb5xNvTM1XZttsSR/YBbPI86kpLyC8NQYIHgoBD+amSw7BdMXnJ6zYKdo+ohZ7iDw5rr/Sql7lqRyDu5TAnjdRb9yFRtC53jP+RDWJkBQ6Gkyk25x+28/lp6rbm9DdkR1GShTpp/CZl22JoaTXs7Jayzo95myUYp7h0ZmGIbMVPG23MlYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtWEd1eE6KQHpSc+XY4qZSo5mNeXCeiZRHLTRHkDS8c=;
 b=ZZIerYlHY6LyV9MuvKIzg1ncEdtEpi4UFmhaCaa0121eoBW0kSm2KE6A3M5Rc8tVS7kdCY4nyLfNj/mXQ9B1FJI5hd+bAB/O2p5Itxd5C75QgiJcPn/PZ00BD5vLZtMA0nRsG71zCzOwBQ+s8A9X1U4bn/ELYSJedMRUlk+8hQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 PH7PR01MB7821.prod.exchangelabs.com (2603:10b6:510:1d9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.43; Tue, 7 May 2024 11:03:03 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::d3dd:ece:637f:bde9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::d3dd:ece:637f:bde9%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 11:03:02 +0000
Message-ID: <26bbc8c7-befc-4d2a-baf3-2156c740bbc9@os.amperecomputing.com>
Date: Tue, 7 May 2024 16:32:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
 scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
 suzuki.poulose@arm.com, mike.leach@linaro.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240429152207.479221-1-james.clark@arm.com>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <20240429152207.479221-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:610:e6::34) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|PH7PR01MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 3199ee9a-3471-4cad-2236-08dc6e8543d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVh5eGJ1eVMwQkJwbHRHQkgydGhQZlYrOG55WFRBVC9BS0dSN21VZmFUZ2wz?=
 =?utf-8?B?NTJEbk1mdyt6dXlkUitIc1FqSGdyUTVlRENLUnpzU3lhTFNVamYzT09IK3Zi?=
 =?utf-8?B?MTVRdG9HL0dGZGd5S0FBNW4yK3dzZmxKOXhIN2p5bS81QitvNkVZbUMzamRs?=
 =?utf-8?B?enp3R21KTTZxZHVXZjFiUWdlUFlWSjhvYklWY3NZaCtlS2FLZWQvanFrWDFa?=
 =?utf-8?B?b2I5dlFvNW81bHdOTEJob3RsVXJBVmtEay83dVovVENvQWpOV2lXczUvYkxl?=
 =?utf-8?B?dmNpRzFpMVJ0OFRsZjJXQlhpdWtuU2I5Y0NhQklMempHTjhNbjlZK3F0TE1T?=
 =?utf-8?B?eUFYeFl4K1VyaXE0ck9zRTBwRitXeGtXd091RWZhbWN3eTdNdzlPVzhIazNO?=
 =?utf-8?B?cjdGa1pUbFFxZzBoZG5RR2VTSWlVbW56eGMxQ3kyOUl3N0JRQTl1K2NFRW1h?=
 =?utf-8?B?VWptWlBUSlpBTGdpZGJESm40VTk3OS84VzdHZFNDUU1RTGJlRUpYTVZQK2sr?=
 =?utf-8?B?bHd1bFVJYnVjWS9CVlZhT3FlUlQxdnpxU2xTS1A3U1dEdzlMZlhmNmtiaktP?=
 =?utf-8?B?bmdXVitPb1ZUMGxCTnlxdVhrZ0MvOWJBYmVzaG1RMlptdmlHOUExeHVFZEVB?=
 =?utf-8?B?S2k4bm9XcUlEdGtJS0wvektpYmlhNjNRd0hENlpDUXNoRklzSkd3SUhPdDhY?=
 =?utf-8?B?ZW9sNG83RWpqclRtTTFpdVZNejNZZUVsS1hjWUhzTkx5bjloTlZkd1JBSm56?=
 =?utf-8?B?OVpCQlRZVXZVNzhYQUNWZDJpMGNLVmNPOS9rUzJnVDBCbFhkVFR4aGtnZlQ2?=
 =?utf-8?B?cy9nVVFNRjQ0QXNXUWdRdTRMbFhweEZ6UUpiQmo4Z0FUMjVCQnZ2ZWFZSnJT?=
 =?utf-8?B?RjlhUFpsL0Z5NnN4VEFzZ2pQY1labFFob0lTaGZMaHpkREwxWlVoRUxrYnFM?=
 =?utf-8?B?N1ZZdkJKZFl2ZWZmRyt0cW53VC84cHhWbWJnVDVwc0NVazd0V1E4cWFTd2JH?=
 =?utf-8?B?eG9OVHZCcnJRQkVOWktiaE9oeXc4dldLWUpLZXZIL2dGVGhUSFVzV3NJcWpH?=
 =?utf-8?B?c0tINUxwL2kxbG5HSTVpaXcyRlRsVEFBclBMV2p2TU1XRDNndy9xUWR2cW4z?=
 =?utf-8?B?Vzd2RDVZR29UV2RaUTJBbTlTR0RQWjZ4dWtaTjZrZDRabEpuTVVyWStaSVFs?=
 =?utf-8?B?U3RwbTRuZW5KWGxtWHQxOG5HaWNNOGxmdEFaUDRIZFJVbDhXUU5RUTAxQThr?=
 =?utf-8?B?ZUNSYWVleWdHbUZ2OXJmcmxoM2tkTHhVNGx0NWlmcElWRGVrdzJNdHFUMUs5?=
 =?utf-8?B?OTNYU2cxUEtMZ1RyUU9tTTQ1NjhmTmUyOS9CakgxV1JPcVJTcldNaC80OE9W?=
 =?utf-8?B?YldrcFZHTUxxY0tEaGhscHJkNGJwcWhiMVF0TlM3eXFKQWU3bVV0MUJrQm00?=
 =?utf-8?B?aWxQZWJFVHpCam1XRmRWL0ZZb1ZiSkNBV3UrY0FUK3ArR1ptWVA4TjNTOGFD?=
 =?utf-8?B?aW44MEVpd1o0dDVMZERmMDJRK2tKK3pyUjlydXAzbnJOY05Tc2xUSllFS2pZ?=
 =?utf-8?B?N2NYVjZybHp5ZC9ITitlV2ZmS1NJVEFoTzlQSlliMzZ6bi95RFJpTXhKOWhk?=
 =?utf-8?B?VVlLem1hRFUzY0R5ZDBNbnl2bFJnMGtjcHFWUklhVWorc21iaXAyS0lCRXVL?=
 =?utf-8?B?ZXZhdEU3SjhDYUlYSy9EMCtaRzcra0dzYjRKZU5MdG51MmZoMmV2T3RBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2p0RVFsbElQMnBPaTFBV29OTllNTDFIblBkcDF1bUhLVlo5OEsydktMeURY?=
 =?utf-8?B?ZEpvZ3N1b1h5TGFNWEVPQ0g4bTRnUE5BVE5walA2VEgzdnpvcGxYZnVpbC9H?=
 =?utf-8?B?U0MxNkd6UUJGam1uUTQrR2Q2d2loTUhXdy9DZ1pOYlBnUlU1dTVjTXIzdHFq?=
 =?utf-8?B?ZG9Qa3VlVk9sK2orVzRiMkhFaDBSaUVEaHVJQ0pLcGVzSEhsR0VPN3dVV2Jz?=
 =?utf-8?B?b3Q3di9NeHQ2d3o4dk16aGtXajBsWXB6S1NldjMzM1ZyZWVycDRVenE2Uk16?=
 =?utf-8?B?UjFnR0JCeExtcUtYMURTK0QyQ085Z2xHZ3F5RVNWbG9wZzZCVHRhTG1pZ0hk?=
 =?utf-8?B?cnFwYkNoZU9KNWtXbVpiVkdXcUZrZmZqT2loLzd0cS9BRlVySmxKc1RGRG1L?=
 =?utf-8?B?WUwxN3FIcUY2UGJJWmQvdytGOEF4TmJ1dzdmOWxEYUh2TTkybjdVQ3lraWcv?=
 =?utf-8?B?TlA0UHh5eHI4d0cyYjdkSzgxVGN6N2pBTUpwOE5QQU5kMzRnTCt6UGQxMnNV?=
 =?utf-8?B?V0Zpd2ZEcjhKUU5NZWJvdUVRUTZRc1d2bll5U21QNzl4SFpnMzRUandHK0hz?=
 =?utf-8?B?STdpR0RTY2oyRVdUU3dqeFVhN1ZQUm1zemdObjkvaWpzQ3dEakhNc1VGQWtB?=
 =?utf-8?B?YlBxTGhnODJyenBKeENUZTN6VElHaFJscXpoUnhHNk1OWVQzU1FtYm1wWFNk?=
 =?utf-8?B?TExQWXlTd3pId0w4NTFsaVpUQVZKemhKcjB3VHlZaFhSWnlpK1k0TzFOd2F6?=
 =?utf-8?B?S0szNjVzTHJUNDFkbHp2aEszRXQ3ekUrTjZxMjduVUxrRi9sV3RhVUNRV3JG?=
 =?utf-8?B?b0tvTnkySllhUzZoQ1FGVmxTNXoxSEdQZFNJenJ4d1VrSk13NjZkSXFIa05K?=
 =?utf-8?B?Z1VPdTFDa0hxNUFSbVhlM2V4MXdaSDVGTmFLMGdUZ2pQNVJlb3QxWk9pUTdD?=
 =?utf-8?B?aHVGUy9zTEpvV1RQckltWVBSNk1UaXVqS3p5U1lyU2l2dHhwaFFYV2RFT3hZ?=
 =?utf-8?B?M3FHN2hKaTYyWnJaRENROVlXZTk3aXdWVkJCbUM1eWcrRnhaMzg0L0laY2c1?=
 =?utf-8?B?OFMrN3Jkd1JJaHhGRDlKS2ZZTjNIN3B6SU13OTdaRExGaHV3VURXbzVjRExy?=
 =?utf-8?B?RGNyTEFyVXNhM3FaU2dhNUhvdmZibS91bXNWZUg0UGJzZGVHS0xSejhWTmtD?=
 =?utf-8?B?aW8yQ2VmZ2Mvcy9lWlBvTFYxWnhhM09SU0NEMUx2bkVZQjNFVXZPcnFTL1pZ?=
 =?utf-8?B?STNONHBZZFJZbmhhSEJWRnhRMy9UNjRqVE1PdkF4R01pdk9XaHRSbGlHMG9j?=
 =?utf-8?B?VmM1ejBLR1dRdXI2clJCb3lIUXNZNzF2Qm0wQysvUG1jWUs1ZXJwalNBdWMz?=
 =?utf-8?B?djFtR3FpMTFVaGZTYm1iWlNweHhkWnJUcEMzckJXNC9QYzhNdFl0TEJQMFZ1?=
 =?utf-8?B?cVpoR2xTYXdLRXZQSUpHdmcxM1JTVHZ3RnIwRlI4Q3A0OGxwSEYrVkhNZXho?=
 =?utf-8?B?MzN1Rjk5ZDcxOWgyRUxYVjJUbnJVenJMN1YrQkQzV2JNZlJkK1dZYXZSd0VZ?=
 =?utf-8?B?cWp5VkxoaFZyMVB2RC9TSXlqdDZqK1VOSGJVbjZLWU1BTWF5N09NWjE3bXZs?=
 =?utf-8?B?U3E5S2pJb1VEWDc1SkFHWGZXQUVtQ1VxWWtuZ1lTQkpWZlFkVWd4NmxWVkt6?=
 =?utf-8?B?K09SaFNwVlBTQXo4WUFZQXZrclBIb0RhRk1zNm5rRXlOZ0E2bHYwek5EVWQ2?=
 =?utf-8?B?NEw3YzFqK0R4R2tOYm45andTNU10R2tDRU9KMjdQVW5kcis3UzJ5bHB4eCtV?=
 =?utf-8?B?QkhJU0xsUnI3Q2RDbWVXVDh2Y2xpdlNnUFZmaGlKYlQ5Smw4bU5mNnV6THVR?=
 =?utf-8?B?UG5Xb010RnVRbHRUOHN5dTVVdW1xd1k4Vm1LbzhmN2R4eWZvM3NJWmx3em8r?=
 =?utf-8?B?Sk5NMXE2NDl6MS9JZmtlN3A2aHpsUkpVbWx4Qk9vWnN4ZzBPWHBoNVp2eExh?=
 =?utf-8?B?OEltRXNaaU9DSGZSZFFRUG5DUzBCeDlWRXk0bENBUk4wWDc5NDF3Y2Y4RzdW?=
 =?utf-8?B?bkdWN1VsTEVFb0svbDJiZldsNmNWU2RCamVzVlBHdWNkbFJZRjBPVUJhKzFP?=
 =?utf-8?B?Y0RoSUdlV1Z6RzluNkttMytQMW5nbDVnNU5hWlB5TllGVG9SRVR1RUl5Szdv?=
 =?utf-8?Q?79N44F2gi2Qfb71cXHg1cCA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3199ee9a-3471-4cad-2236-08dc6e8543d2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 11:03:02.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zn7PoeFC+eZDGr0Y5W4U+ftsctnHecyyeZipGxalqaw5cidqEkS6GKY4ONu8nyZlGeT27TAKcQnLkvnwVSIirktnWYRbMyHvENQIl5konSF4Wk8fw1aOmpM85hH5cfZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7821


Hi James,

On 29-04-2024 08:51 pm, James Clark wrote:
> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> as long as there are fewer than that many ETMs connected to each sink.
> 
> Each sink owns its own trace ID map, and any Perf session connecting to
> that sink will allocate from it, even if the sink is currently in use by
> other users. This is similar to the existing behavior where the dynamic
> trace IDs are constant as long as there is any concurrent Perf session
> active. It's not completely optimal because slightly more IDs will be
> used than necessary, but the optimal solution involves tracking the PIDs
> of each session and allocating ID maps based on the session owner. This
> is difficult to do with the combination of per-thread and per-cpu modes
> and some scheduling issues. The complexity of this isn't likely to worth
> it because even with multiple users they'd just see a difference in the
> ordering of ID allocations rather than hitting any limits (unless the
> hardware does have too many ETMs connected to one sink).
> 
> Per-thread mode works but only until there are any overlapping IDs, at
> which point Perf will error out. Both per-thread mode and sysfs mode are
> left to future changes, but both can be added on top of this initial
> implementation and only sysfs mode requires further driver changes.
> 
> The HW_ID version field hasn't been bumped in order to not break Perf
> which already has an error condition for other values of that field.
> Instead a new minor version has been added which signifies that there
> are new fields but the old fields are backwards compatible.
> 
> 
> James Clark (17):
>    perf cs-etm: Print error for new PERF_RECORD_AUX_OUTPUT_HW_ID versions
>    perf auxtrace: Allow number of queues to be specified
>    perf: cs-etm: Create decoders after both AUX and HW_ID search passes
>    perf: cs-etm: Allocate queues for all CPUs
>    perf: cs-etm: Move traceid_list to each queue
>    perf: cs-etm: Create decoders based on the trace ID mappings
>    perf: cs-etm: Support version 0.1 of HW_ID packets
>    coresight: Remove unused stubs
>    coresight: Clarify comments around the PID of the sink owner
>    coresight: Move struct coresight_trace_id_map to common header
>    coresight: Expose map argument in trace ID API
>    coresight: Make CPU id map a property of a trace ID map
>    coresight: Pass trace ID map into source enable
>    coresight: Use per-sink trace ID maps for Perf sessions
>    coresight: Remove pending trace ID release mechanism
>    coresight: Re-emit trace IDs when the sink changes in per-thread mode
>    coresight: Emit HW_IDs for all ETMs that are using the sink
> 
>   drivers/hwtracing/coresight/coresight-core.c  |  10 +
>   drivers/hwtracing/coresight/coresight-dummy.c |   3 +-
>   .../hwtracing/coresight/coresight-etm-perf.c  |  82 ++-
>   .../hwtracing/coresight/coresight-etm-perf.h  |  20 +-
>   .../coresight/coresight-etm3x-core.c          |  14 +-
>   .../coresight/coresight-etm4x-core.c          |  14 +-
>   drivers/hwtracing/coresight/coresight-stm.c   |   3 +-
>   drivers/hwtracing/coresight/coresight-sysfs.c |   3 +-
>   .../hwtracing/coresight/coresight-tmc-etr.c   |   5 +-
>   drivers/hwtracing/coresight/coresight-tmc.h   |   5 +-
>   drivers/hwtracing/coresight/coresight-tpdm.c  |   3 +-
>   .../hwtracing/coresight/coresight-trace-id.c  | 107 +--
>   .../hwtracing/coresight/coresight-trace-id.h  |  57 +-
>   include/linux/coresight-pmu.h                 |  17 +-
>   include/linux/coresight.h                     |  20 +-
>   tools/include/linux/coresight-pmu.h           |  17 +-
>   tools/perf/util/auxtrace.c                    |   9 +-
>   tools/perf/util/auxtrace.h                    |   1 +
>   .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  28 +-
>   tools/perf/util/cs-etm.c                      | 617 ++++++++++++------
>   tools/perf/util/cs-etm.h                      |   2 +-
>   21 files changed, 633 insertions(+), 404 deletions(-)
> 

Thanks for implementing trace-id mapping per sink, with that we could 
try perf (coresight tracing) for more than 100+ CPUs.

Please feel free to add,
Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>

Thanks,
Ganapat


