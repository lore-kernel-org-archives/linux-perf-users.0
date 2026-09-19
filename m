Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04C33EB1B;
	Sat, 19 Sep 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828180; cv=fail; b=uIw+OpbTn/GfrQGFho6LCJ7GBVed3QP5uD3fJx+7bkL4bZ6TW8tZeNauNnEgnmHhxgzRQjWNb5ThX2KDcJY6YUBY3wlmMpI0pLap2X6hPcvaquOU8AvmMlizlgeH6ube7N404OzS3dvDlBfBu/Bhr9cfbWF4g6UNBvJaaPbj/xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828180; c=relaxed/simple;
	bh=LSEWyAkviuNcAhoACchZrgP2aUm2te3hAvHahNpsn+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dljqq1EQO3MZwBSK4qb2lep9lNP/Fbc8UenDntw5BYnX4jsQRUMLmbGi+fI6XsXGhU5cRb9eonUNmeMXI1QVjwYfenyidPea07FXZruJ6Z+zc8v0mivBAtqhJVg1abyed4E8uZFh3KqaGxXExW9JpKLmR2U1kiazzCmRqXWSg1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GqAYNGqc; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GqAYNGqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swtQBQxVFEUdsIfJheE/5OME4ij+nv4URS0jdP6k2VomiRWqfId/zkZXyXPkg8ltZdzsuCAhT9dOz46sE7AkW/dVVjkx5jsSgBL1m/frPQxhEWTrro8nL9WzKG2N/31PuGGTIIEwrgvtWwLTuX3o/XEixmY+2HkKezdrOeZYVZ0QYFCWqwQdMsUp483QJE7OriarVM5IyDhr3jorjVGPXdAt4c14oSyljVZE+DEovpP9nuqIUDjjKaFY7KSjzRdJ/1XTrtu8y8IqYcRoWN11VABto4oyVJ+1PjNqvLneVX/RgGaqxZIiG9CIaWTgqqb/J2M+QDb3k8Cy1wI8pqgIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2PBkNRANm13qDTknfT3WStUl0xbCTjRopOQy+l6mGg=;
 b=rGKzkDusibd45PJAdt/vh8BDf7BhOvaVh86vbumGCQWrtKbf6kFf27y66Qs7PHL2S9JQAMyv7Grko2VDqOW5ZlP63cdr79wuGiVlbcDEdIMiEilX7NxrVZuZDOJcmOj9Mgbm2BfpsoHt6VcSAVDnYQy/W2iukNKTrG1br7xc7PKS4GArShCKCxXSg1Bmm7HAvmzvhXgYmANarwY1yRaEuzTGEy3gj3tjJDlzVB/vNU0kXIMErABxkqXUDEGG6Py8g+s67L4aGx0teC7dYpMuZTOio2bYHC9zpBrjEmAvVYpXMwWQrHwHd0T7G3Ccn9/5F4GAGmdMaSbxYdtG7fS2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2PBkNRANm13qDTknfT3WStUl0xbCTjRopOQy+l6mGg=;
 b=GqAYNGqcrbjKQgNAP6H2Ui+OfRbCUPVsu80Z8PTkGIi3sPNflkP9Oo4THI+TIRWv8q0q22JRHR3GMvzKkgzAgOJhK4RvPPzM3v7MtwOequ/i1gqJEGJdIlHftArwJzIjf1SEYjFks9YUdWSE1eLPKXP1u3AjuVXhEp+hN0zI+UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 14:29:13 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 14:29:12 +0000
Message-ID: <c86b2d33-28a8-4d62-9604-658ab3a5c12f@amd.com>
Date: Sat, 19 Sep 2026 19:59:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/pmu: Don't retry a counter whose config was
 rejected
To: Sean Christopherson <seanjc@google.com>,
 Luka Absandze <absandze@amazon.de>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260918160006.61816-1-absandze@amazon.de>
 <aq1j0aUKpr15AiqS@google.com>
 <aq2ZCFXMDnUWwCuY@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
 <aq2vrDkgfPGeJ-wD@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <aq2vrDkgfPGeJ-wD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::10) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DS2PR12MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: 639c7bef-a933-459b-7b12-08df165a6005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	W2ILYx/fQ11nsc+Ihl+iv2Az/zyRct1nLJ07XQGI58wSt1MXRUd1IE7qq9KlMAMYZzZjtsVFWWtMVv/zllZ6tQmNuWqWHO0rGKroCswmbv4znEO5dcSNvhsMYUtM70K8TZLjHRNRgH7f7joUKK4uMNRz3cL1adsxPK5neTahOEz4KUzhiwsMUDNC60y1MBIA6JuNJFAHwTWrqQpQHn4lazU00mNnm1DNXiL/TAXh5ybNsFlWjp9dw/Z5tU9e1u5jsmD93yv+2uQ12i4HFlU4UGJZezOM8mpA9Wwe8ygQIZXQ1y92CWXKjtE10r+Mf9koWgqzC+ge5zv3RXAAMS+uSJgqeSJxi98Ll1BQnSgOk5MrouCSmWowY1NsX8zsgwd14NQV4NzH/8ybE4lQ0R0yM+D+Qb8upuBZ5bh9vc1AaMoCfL38XD47kPlrxmxfPfenFd8ir1IeHBC9dZkVWWfrX+mGwNR8qrrqHgTt+tK/zKpxPKLaLZxYknWM3IF+qKku/NngCDD497SMADgRh2kEfq2QIwyjAeYRoR+whcQ7xr9FDWN80F69kgp7Vo5B7hz200rJCQ9z7k11YX2wgia5gug8g0RpT4JZRis2yCpcZwATY3XV/0Y/HD1+5Bk4pzeJ+SrIdnJwaGnm/rQfa4LpIKyP4PN7qvLZhkpWqUpsHPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FVYko2NEFYZitsRlk5NTkrR0lUWGNSTnpmZ1BFMWFmR0YxdW5JMlhFRDdz?=
 =?utf-8?B?blE0N01SMXF6RzNEelJuNUJ4ekFwbEMwdVhmcWJtOVI2V2FBdVI0d0c4L1Ni?=
 =?utf-8?B?S2tBWisxc0JDbXptYVhzSlpCSXhDdTlyZVdLdEFSZ0RQVjdobTBYYTh4UTdp?=
 =?utf-8?B?WlNNamx4SmlZamE1SHA4YytOL0RCZDBlMmM0NFpFbkdMRFV2bG1pYVJLSFph?=
 =?utf-8?B?eXpBaG9XUTBLTGNyd3p0emtWNmRmamVnR0F2ZzNNQzZQb0Y5Q0h4c1ZuT0pz?=
 =?utf-8?B?UWJ4ZU5BME4xMnZoNEtObFRuQW50aWpZZkg4RFFXdXJxN241c1pKQjBUb3Iz?=
 =?utf-8?B?T1kwRkpPVy9ZRmRHZ3h6akM0QU1MR1JRN25xL0gvVW9tUVBjWWVNQUoycjNp?=
 =?utf-8?B?VGhQODRNVm0zTEQ4M3Ywa1FJZlJpZ2htM3NvMSs3YURmMVVUT1ZaRWxGNlFW?=
 =?utf-8?B?NTZNbGhLaHlXT01mUXp6S3BhWGYxTS85V0JZWTFYNHFyZG9uQStYbG9LR2Vo?=
 =?utf-8?B?TmFQQVBRWUN2enUvVHhoMk9sVUVrYzJQd2JXME9XSHhKUSt6THJsWGlKcnVG?=
 =?utf-8?B?Z1FJSUxuMk1UbkJ1a1piYWVtQmt0VTd3WHR3dmlFZTVKdUtWeVpqalIxU1p3?=
 =?utf-8?B?b1hiVWpHZlJpZHN2WXBsNDdXODVIWmtBRWtnSW1ob3c2SGx6aTN4eXRIZldW?=
 =?utf-8?B?T1lRbFZnTDhtNk9TZzJqbjMya3lTZlJPYVVJbkFJVGIyYXQ5ZElzMkR5c3VO?=
 =?utf-8?B?UDlqSWdJQ253citIeDNvR1hJWVlJRGk1VmtRczdpNGc0R1Q1MkpZcVU3eUFL?=
 =?utf-8?B?ZDBBQXRHaFJ4V3VCU0o4dFhRR1dEelpzVjJpOFk3d2dVbnQ2bENNejRUMU9o?=
 =?utf-8?B?ZjVyS2xzcjZERFJkYitRMkY2c3FEVXQ3YUMyZ0o5aEpmNktCR3p0bXhsRTkz?=
 =?utf-8?B?ZFFrNmt6TGpjaFBXZUJ3SzdJbFBkaTdmSWdKZ2R0YjkxUjI1NXppL3U4ZWFh?=
 =?utf-8?B?TCt6UTljcy9DSjVPckZKZWM5aEIzRVRnLzNJSVdvWFpqbnJDcVdJUjBORmhG?=
 =?utf-8?B?Wng2a3R2b0d1aHUwUUhoK3I3Q012ZFBYSDh3aGlVR1BobkUvMHkvZHdSWVpS?=
 =?utf-8?B?cGJNWW5ZZ09GWmJhdVZKNWFmaC93S1J0bjI2aXp6L29nMDZDenFVd3Z2VkhP?=
 =?utf-8?B?bGFTeWNpaUJDNmgwNW5HYTQ1R3p4S0JVdHVwUFNoN1R2bDFzQys5djhWc3R2?=
 =?utf-8?B?YUxoSjVPV3V5d3I2U2I1KzY4TkF2RWkwYUxEemRjWjhtUzlaUGVob09wMFBk?=
 =?utf-8?B?Mm41c0ZZMFZITDFlTHM4SytKNmpwbFc1SFRxNExkOHBYaUZtTC9lUW5DZkRE?=
 =?utf-8?B?QUlYZHRaUUJuaHF0N0xZSTJDV1lLQWl3VkVRb1J3SlVTNUF1ZmduNzA1aXRu?=
 =?utf-8?B?c3ZyMVUzUkdTeE92YWZ0cjdxanAzTDBObzFUQVlWZlNDWjl2TEdHOUNPc1g2?=
 =?utf-8?B?cHp4cmtYa2xPdUxXR1VZZFlrVlZFK2hhZm5wb1FXK0ZyTWNZcFEwTmdkQ1RR?=
 =?utf-8?B?YWpyS0hjOFRWKzFtekNmcDZuSDk0aTI4UHliMFBScjFiRWsxQXFEZng0MzZP?=
 =?utf-8?B?RGsyalZBYVNPZWxJbVRyMk9VUUJLMERWMTFadElzSWh6VE5Bb282S1NGUlI5?=
 =?utf-8?B?UWU3UjdGUmYxbjFUMy92dVRzZHFFaVdyQ0ZaWVFsck9FM2RUcUIwbjFJRE5t?=
 =?utf-8?B?dGZEK0h2Q21GcnM1SHBvTU5JUWE3YzlLM2FLU1BPODZtUFN6bk8yZkFrNlpZ?=
 =?utf-8?B?dFk3ekdBeTZ3MU1aTzJ1MnlSZHJWUHlManF5Vm5wSGl0cUZPT3phSkdMYnBj?=
 =?utf-8?B?b0N3eU8zdTArZ3VEMHpXanN0N1hxR1FJY2RDbkFRMTVaT2pqRW1EQitWYk9G?=
 =?utf-8?B?clpCQ3RONHhUWGRWbVZuRERqcWJzbmMzT2ZtaERWRkVtSkJ4UExpUFdscnQ4?=
 =?utf-8?B?YWR2dW1tZUtzeW5IMkl3M2tYNW9mTUJDbFdZTENJNG1jcUh4a2NhZVlDb1p4?=
 =?utf-8?B?Z2VPQUt4NXdXeGZiZndEeGhGdmhOcHZmbkJOeUNpUWpsS01nZGtUMWpYZnhV?=
 =?utf-8?B?eDdCNFIvSEVickk2R1Erb0NBSE12VjBGdGpNVUxuYTIvOFc2bm92QVR2eStn?=
 =?utf-8?B?ZStvZ1pVSGNkdm44L250dDlCTTlvanVYZXdlYTEzT1BKZkJ3bzQ5Rjc4M3VH?=
 =?utf-8?B?TjNyalpLMWRtODl3SHpPLzV0bnZ1eWpCeEJzNGVBeXpkSVNmZWVPNkVDRjFM?=
 =?utf-8?Q?z2LG2JrU/mVXMMuDdc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639c7bef-a933-459b-7b12-08df165a6005
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 14:29:12.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gng9+yKOgZsFpXj3rv0czNBNpnEHY2YfNQIOvoLhZfMAz6AHLEhjzcbXUaS9y3HEK8FV+qj1uNpSHf7yChJSWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711

On 19-09-2026 03:09, Sean Christopherson wrote:
> On Fri, Sep 18, 2026, Luka Absandze wrote:
>> On 2026-09-18 09:16, Sean Christopherson wrote:
>>> Hmm, would it instead make more sense to explicitly check for -EBUSY?  -EINVAL
>>> isn't the only fatal error code.
>>>
>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>>> index a7d60c8785cd..5296ee8f32af 100644
>>> --- a/arch/x86/kvm/pmu.c
>>> +++ b/arch/x86/kvm/pmu.c
>>> @@ -681,7 +681,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
>>>                  * PMU refresh.  Don't make a new request as doing so can stall
>>>                  * the guest if reprogramming repeatedly fails.
>>>                  */
>>> -               if (reprogram_counter(pmc))
>>> +               if (reprogram_counter(pmc) == -EBUSY)
>>>                         set_bit(pmc->idx, pmu->reprogram_pmi);
>>>         }
>>>
>>> Though I guess one could argue -ENOMEM is also transient?
>>
>> I had contemplated this, but could not convince myself at a glance that
>> perf and KVM agreed on what constituted a transient error.
>> I have now concluded I was seeing ghosts :)
>>
>>> E.g. this? (completely untested)
>>> [diff]
>>
>> Tested against the fault described in the linked patch and selftests on
>> AMD Zen 3 (although I don't think there's much coverage in this regard).
>>
>> If no other objections, would you be fine with taking the diff you
>> provided into the tree or would you prefer a v2?
> 
> Go ahead and send a v2, I want to see what Sashiko thinks.

From a quick glance, it seems EBUSY and ENOMEM might just be sufficient.
The former occurs when a pinned event cannot be created cause all counters
are exhausted and the latter due to various event and context struct
related alloc failures.
