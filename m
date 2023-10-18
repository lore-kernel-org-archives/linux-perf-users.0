Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD14311C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IbVon5U5"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5944CBA
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 20:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxeSzEUtqdcok8WbEvbowy5AbMXKmq5cNJ/a9rEWsw2GOthHu4TkrsIAWacS/5yOVy/7xQytFqTP1abkcbc0hH3qmYCorLnJbfGwTxAJp7SlNGUvP2hiSgpjUrrBD35GZJy25OBxrEz9VfB2lM8T0iydzTxOHHFvW1TkbY2v3R3UVgnriRk6vUu1OQPtReBzVqZnJQhF/WtN4UwucOncVASecZowVOJpA5urZIGIxXoFIMxy7iUAvU/hBTaNAuh6ZXkPwCb3KAdd3hRdgfmYCukqXh21q6jk/gtoYy4mpvfL7aTpHNC+y2q4HwYr0nVV3HQYxP9/lFEkFIjQwwo6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu/0fjU5UR4Qj4PrySSlVLyvBzlIXSEEOkBspX8AeUU=;
 b=VuGbtsJnurIky7zY+Yryar5QKCVh0Dpj7DdXA36m0rnT4yf1XNAQtLgNao1Qz1PMM5SjAS6ZfTJuBjpe1+U4GuZysEosNE0pD2cRj9BRsYq1JFN2erDOJU9qAJclbh6wrWz7WtcYBvKniuGEToOY6br84/HzeQaYVHNA1ezqnV6Gl5rrbL//woX8+un1/Q793odWDSe0yokma+RrvBoDaLQcmRoDYrPg0UVxou31TLFR8Zk9SLS5l4uigQxRPSJDj21dV7tSoSmU0KFj37MuzFxgRSjNf6Gj+TQRRcCvQXkr/aXKT9r4Fcpetb7sw3yG2lEx1W5DLKFeSAOz/U91Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu/0fjU5UR4Qj4PrySSlVLyvBzlIXSEEOkBspX8AeUU=;
 b=IbVon5U5+WHXz2fb9qhSBdrBHJiiJA4Ks6R+BSvjyZdB15RLZ3hAmsRDAtEdhmUmu05fav4czjtVBqUUJK3C9NW2yXmdY3H+cNmrTZr+JhI3pATQMm9rabUMP11BH1851iYQsjtaA5MR0aRRkUnjey2YHRcG8nBRqN0DuqoL080=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 03:59:09 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5272:f678:1d97:c94d]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5272:f678:1d97:c94d%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 03:59:09 +0000
Message-ID: <f48256a1-d165-de5b-06e8-29646218955a@amd.com>
Date: Wed, 18 Oct 2023 09:29:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: NMI received for unknown reason when running perf with IBS on AMD
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, linux-perf-users@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, robert.richter@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <ZS0l-k1MASK3547Q@gentoo.org> <ZS2vu8bSBS1/zseZ@kernel.org>
 <9d885140-f952-0018-304d-fbc1e15c33a7@amd.com> <ZS6Ds+rB2IwWmXML@kernel.org>
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZS6Ds+rB2IwWmXML@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c603b4-3ea6-4d0a-8663-08dbcf8e94cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ooglE3B5/LftxEQzmym/0eksO9ShWJxyK1kjPuIESqf3X34tNOZR33irpoyYKSF5n8LF+8PqSd2rdyLl0a1MdYzH94DL9H7g6Tnd4k+AXmXMfkgLmzXnNXKX2y/4pM0/Cm06ilVeijFaQ0o9wjTOLyHiJvtcx8lvtHYd/qUfCLb/tEltfXxGJveYiapx9NpWw1ajrkHyGcl19eD6tguIs2Mi8EqF4Rghtw2zhEUrOqvH/CeSmC3aT3veV69vcMHPfYvYc4zD0I0dCP2xkfUZZoFvyJw6CxuD2neup3dIOMAdkXyiRIJPH1wGu1hZrWBnv2/mkkwXQ9ttTOwAElpDYB2+ShZlRrnL0C5qdj93dTSf9R/ZZ4KkC6eHDfCwuSiJW45+NMPDTkqPRvcBD+O5tr045Rhz4YQDjHqfrXi/oWwViwmkbg7iLhJnCUvhetS9WyztM1SmM/JoXelEV7pDTU9VIK6OclRXDIbzzPfsxfC4L52BcmiFsjY6vQhFJ72RFJdjOCI1GFZ5qoOY+fgVWVNJ/BW1ybx5ed13QM5RTvSDdlFWDuMBD0PzP9bKQsJQNzK26T8igpxpmhavnCHMiqO9AbMCc08ayqMeufMxUOG56oJBR3bcOmV0ftIvePaUg2VPXtotQfBGgnLmdur1oA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(54906003)(66476007)(66946007)(316002)(6916009)(66556008)(6486002)(478600001)(6666004)(31696002)(2906002)(5660300002)(36756003)(86362001)(8676002)(8936002)(4326008)(41300700001)(44832011)(26005)(2616005)(83380400001)(38100700002)(31686004)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SktQRFRwZk93VVFnVk1aamtnSG1CYzV4cVcyUXdzSVNORk0rRTVIdUU4QTRR?=
 =?utf-8?B?aStVK1J4b0w4OWUySVRTZWx4THlqbjY4VzRwc3N3K3E0SmtNK2RTcGozWWdR?=
 =?utf-8?B?QjNHQjA2VnV0UHI5R21FWjZoM0FmOWVSYXBwVnlwd1ZJdzRtVDVFek9ETGRx?=
 =?utf-8?B?YnJPRCtDTktPdTc1MDc5cFMxMmJwdDFueC9yRmgzdndibEIvdG0rNERmbnNV?=
 =?utf-8?B?aWs0UXczbFc3dWpKVlU3VWJOaW9XQVMrQ2FxYnJtYlk2NDllZzlMaXE2WFFn?=
 =?utf-8?B?RUxPQTlRd3crSjNQOGJ4c3pLZ25qK2ZTN0F2cWF1RDRXQ2MvZ256VkZRNXhT?=
 =?utf-8?B?RmxqZDJtN0JRbG1NWEltcGNseE4rMnpFVUd0cjdhRXNUVFg1RmFPYmJXdldz?=
 =?utf-8?B?NjVKcFVteG5pLzAzcUNsSVRMb0FjZldPRW9HZkRVb0RGNXcwVVFPOGErRFl0?=
 =?utf-8?B?SW0rOG16aUZLNXhnM2REbzBDemk2SDRPWFh1REVReGVBWDhiOHF1ZHcrRjd2?=
 =?utf-8?B?ZFVFSFpDbHFEVVhnZ293dERiMCtLSEp4RFZVekNrMDRQc3p4NzVRK1NXU0Ri?=
 =?utf-8?B?UC9rN3JXRVJsMXVoNXJLYUxZNHZUZDBPYWVVUWFjdnNJOThhUk1HcGpCT3di?=
 =?utf-8?B?bGNYVXdMTXFDMTc2SVc4K3M1SkRrdjZHSS9yYVFUM0VJQXBMWDNYT0tvb2t6?=
 =?utf-8?B?Zjh1ZFZIYVJRS2pjZmdsbDE5OHpIYmIzRmx0WXhiMkYzZGNFZGoyT0ZiVUJY?=
 =?utf-8?B?aEMvVGN1dmdXejBSTFBMcTNVVFlUVXZreDNiUXlxZzRmNFRZN2ViTmZhMk1U?=
 =?utf-8?B?M0grN25GWGVXV2hCZnd6VVAvTVlSa01BSGdWajJyVEYrb05NNnViOHJnNVhJ?=
 =?utf-8?B?YnYvSmRaQmZSd1BpLzdqRjZqSFdHKzc2UlBJYnZnWGErMmlQU1I4cXpPRkhB?=
 =?utf-8?B?ei9yN2h6SFlESytsbE4rR09QMkdRMDlBbGlvRjVBZnZ6SFlEU09YdjZ4YjlC?=
 =?utf-8?B?OXZqWk1EMFpDV0pyc2UzYkVMRjBZdVgra2xGTDhsUmkvT0ZEV1lKY3daSFpu?=
 =?utf-8?B?L1U2N0dGZHNLaVUwdXBxbWF5cWNhWDJUREpxTGs0Qi9EUjV1R1JuQ2F1d0dC?=
 =?utf-8?B?STVkQUFLKytsaVNVSkQ1N01selVqYW02UTZ1T1E2REJ0c3p0OUdjMjAwV3Zq?=
 =?utf-8?B?ZGdEbUYvZVNRMXhld0lMeFZuTVRSczVQdjVWblpWZ0wzZzcxRzlGQ1JzdjM5?=
 =?utf-8?B?YkNDUEExbm9HaVc0SnJHa1l0SjRaNlJBOE9PR0FobUNaa2NqSEtJSkE4Y1dp?=
 =?utf-8?B?TGV2RXdDaU0yNXUzbk00b2FuZkl2Ym4yZHEvY1JHNVkyU2VRK1EwYU14OWpj?=
 =?utf-8?B?Q2Z2bm1ETnRmU1dKT2ZhNit3KzhWeWxqNUp6R2x0Wk9OY3J1M2VTZlg2R0hS?=
 =?utf-8?B?ZVNTMGxtamFzWkFWWFJ2dGNsV0hMYTlnamIwUGZ1YzdUVnlSa2NTSmF5ZVNY?=
 =?utf-8?B?WVlQWVRuWWVnekIxYmRnU2lzbUlONDZNUzdJY3BTUlJvNXd3QUR4cFpuS2ls?=
 =?utf-8?B?UjhUK1BGekVqVGtWdWZKUXo3bkppeFhsWTFBVkJnS3QrRHFtUFdWMDR0Z2Rk?=
 =?utf-8?B?SjJmMTFRWUxEN1BZeVF2U2NqMDNlcktub3RaZHo3RGVNNjNuSHE2ZnBtZTNL?=
 =?utf-8?B?bWFLYnNjOWJUZ1FEOERUS3hzY2lBNlI2UllNZ0I0dWR6TU83d2FPNTNGNkNk?=
 =?utf-8?B?YjFqSWlWQlhzc2h3QUMxeHliWHZmRkFtM3gvUUxLR3dIbzJCRkp4VkJBZkF0?=
 =?utf-8?B?N05oajZRT2RKUkJFU2NtOTkrdGlydlJYZjBqWFZrcGl0R00xWVFHcDFsbUJX?=
 =?utf-8?B?M2dwUk5iU2hKa1Juam1HQ1kwb3pZT2RhNGRxQTFMT2x5cmZvZ2hESExxb3A2?=
 =?utf-8?B?aHVrUTRxUngxODZ3dFpsYVU3TWJiQUs2aVZlb1FXU055Zmkza1l5YWoxd3Q2?=
 =?utf-8?B?MFd5djB0eUhyVGJOTmhDS1dyT2diT3NaWTEvaFptKzhJVXBsMWYxT3cxa2JG?=
 =?utf-8?B?MUxDdWYrV2pXdkFPVW9qWlRKMHpKNUJZaWdOeWNtUDZEKzVEcVJBRm93VkJE?=
 =?utf-8?Q?nhwwWP0WUvBqNG5ZpRJa0AAQu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c603b4-3ea6-4d0a-8663-08dbcf8e94cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 03:59:09.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuFfWrwalQ3phXn/+c4+eo+wC7O57Bdo+lGhhtc6w9fq8vKRTXmcvxS1s49mYEIf2fksEAlxzHcODQTSKNi7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Do you think we can detect that it is a zen2 processor, that it has this
> problem, and then the tools can just avoid using precise_ip != 0? I.e.
> "cycles:P" becomes plain "cycles" and asking for, say, "cycles:p" states
> that this isn't possible on Zen2?

It's possible, but there is no architected way to detect Zen revision 🙁. I
will need to key off based on Family and Model checks, which is ugly. Also,
the same problem can happen if user invokes IBS pmus directly.

>>> [root@five ~]# perf report --header-only | grep "cpu pmu capabilities"
>>> # cpu pmu capabilities: max_precise=0
> ...
> If we can programatically detect that IBS is present we can add a note
> right after that 'perf report --header-only' line with this information.

This should be easy to implement.

>> Unlike Intel PEBS which provides levels of precision, AMD core pmu is
>> inherently non-precise and IBS is inherently precise. So max_precise value
>> is irrelevant for IBS. I mean ibs_op//, ibs_op//p, ibs_op//pp and
>> ibs_op//ppp are all same.
> 
> This part can go to the man page, where :p, :P is documented.

Sure. Let me prepare a patch.

Thanks,
Ravi
