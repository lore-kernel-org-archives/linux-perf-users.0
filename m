Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A57C04A68
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Jul 2022 12:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiG1MpT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Jul 2022 08:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiG1MpS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Jul 2022 08:45:18 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30056.outbound.protection.outlook.com [40.107.3.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D029FEE
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Jul 2022 05:45:16 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=a2Rq61ZFTv70EvERz0pOXZKb+4y4wqHnrFceHi97yUCZnqEU8N1YLCoVLhYKcwB5brFDohj2Sa3tO834Gje+IqaXNRcuTXaVZnxhunfsceavrOv3TDMMDAl1WQLcrZhaRwBEVGad+Siz7mF6cDdPxSpZsmqUn37U3uqKhIZTOW6NlgKIJl5UzzQZC+aMX3VaN256OhM4mZl7nxVQd3zLGd+Y8aCSJT6GMK6zQtHVRx+W/yYeUGi9mu4sbI8olCBnDb2LTamULLFnT3nBe0R2ig6da1QCag3hvyTYRXtHp8fUdSK0gzpmPmJ8spOJwApmiL/Ojt7XDhW1cozyXSkytg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4/qBjb7pgLfmPUY0gJCUUU40CgCUrj1cqoI6liHOxE=;
 b=ffRtwUKp8wrr0LFJG8MP7EoideWG0s8tCLVVcF8vOR8NTY1T7XoYCpy/LWoaf7UFEGwBB1lnqUny8ifIj1lCYE0KXkZAtAYPWHGoSIUzALEs2AoszIOZnLJvQuRMZPPkkNcMTTWuQP9floV2/gPjiXNl/vv8x8yMmLh9OR9p3ubZzQtyZ3whJAp1MspHPBdv18fhpxKiyfygNxENOzoevJ943sIUPmz9+BCW+Drnln0tTAsLCV7rWAltZVJ4AKHDjjORusq/yqH9ylGj89tSRCi41O8DpPvj6UkcDUwcfza1Xo2TtBjviIOgYkz1GCbmWajBPuugn4g8b37G8qitUA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4/qBjb7pgLfmPUY0gJCUUU40CgCUrj1cqoI6liHOxE=;
 b=2FMPfw45t4/r1oog/OHqyhKx0R4VXDF/LCN7LbfNDz6PizerXfkrJ6HtQyrrnsrTPtwfqZyDLLYrVd2j1SBv30pO9OpTFmvT61zQ9r1HYre6BbOwj2lOlVGCv+6osrwLeU5l9h4nBw1FzDlzsZeQITw+AJQTTLK+7yHXoY2VGbk=
Received: from DB6PR0402CA0024.eurprd04.prod.outlook.com (2603:10a6:4:91::34)
 by DB6PR0802MB2613.eurprd08.prod.outlook.com (2603:10a6:4:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 12:45:12 +0000
Received: from DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:91:cafe::d3) by DB6PR0402CA0024.outlook.office365.com
 (2603:10a6:4:91::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Thu, 28 Jul 2022 12:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT020.mail.protection.outlook.com (100.127.143.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12 via Frontend Transport; Thu, 28 Jul 2022 12:45:12 +0000
Received: ("Tessian outbound c883b5ba7b70:v123"); Thu, 28 Jul 2022 12:45:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2e6fc59257f72ef2
X-CR-MTA-TID: 64aa7808
Received: from 0e4cf4d99820.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 30757E8F-7D62-405E-85A5-C1737373AA2B.1;
        Thu, 28 Jul 2022 12:45:11 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0e4cf4d99820.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 28 Jul 2022 12:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOBZ14cjKF59u19WMv9+5J2zNHmxIKgFooeYd+PG3nnUd6QVR93eVfIWn979BBtrJFkHBYUzvLaOCE2SZ1DJEjf+iStndQABZH8OGObTQr3RQCdA7snGKChbVNDmWspYesHssJTnhdtKEYA9FH0m6zKa5LoRfpXCyMnryatTW/qExfQw/BUGzPDCBKF/MwLPW3c0mP68QFeLQCMrTSTo09Aw58SHLKV6SzpljipfL7kIJw14aLPWiJ16X7nKQynpj1hbPcAXN+X2t4l9ePQIXb/LZ1EjtuKkoTSDng9NcQpM/Ty+CmD1jeywuUbL5kn9W14oiDiajFFpthfFHX55lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4/qBjb7pgLfmPUY0gJCUUU40CgCUrj1cqoI6liHOxE=;
 b=YmM111W99LxFtnVsSUaPI8uyeufOjI2R4fp4dH3s+hfDaXd14ivwKPeooTbfzI+F96ZKEDIrYt2i2RoaTyjwqS9SypqQxBriWV5YnYwHnXbTg//D4sv/PfRbAxtqj1WT4OQh2kozptBCGEhVjiTUchHFdQvjXuhNxq6KeThWXtxSZVaMKIK5kcxDlgiMyj87c8wqR0SfIp8Iird3ScSFMsk9fcIuggmFhg8vz039EbshpKp/IIa9k1aN2EuC8g2rQp4dgSx6V2T4SjCA5bdDa8hc15v9DnuquGdLw2FR6eYo7XVqCtQRxw5MV2qh9xgCTIYJO+RvF9flNIReNZPkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4/qBjb7pgLfmPUY0gJCUUU40CgCUrj1cqoI6liHOxE=;
 b=2FMPfw45t4/r1oog/OHqyhKx0R4VXDF/LCN7LbfNDz6PizerXfkrJ6HtQyrrnsrTPtwfqZyDLLYrVd2j1SBv30pO9OpTFmvT61zQ9r1HYre6BbOwj2lOlVGCv+6osrwLeU5l9h4nBw1FzDlzsZeQITw+AJQTTLK+7yHXoY2VGbk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DBAPR08MB5845.eurprd08.prod.outlook.com (2603:10a6:10:1a5::6)
 by DB9PR08MB7769.eurprd08.prod.outlook.com (2603:10a6:10:395::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 12:44:59 +0000
Received: from DBAPR08MB5845.eurprd08.prod.outlook.com
 ([fe80::1064:7674:3330:b70]) by DBAPR08MB5845.eurprd08.prod.outlook.com
 ([fe80::1064:7674:3330:b70%6]) with mapi id 15.20.5482.010; Thu, 28 Jul 2022
 12:44:59 +0000
Message-ID: <ee574459-f2e3-ff9a-5da5-a634952a726f@arm.com>
Date:   Thu, 28 Jul 2022 13:44:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
From:   =?UTF-8?Q?Adri=c3=a1n_Herrera_Arcila?= <adrian.herrera@arm.com>
Subject: Re: perf tools: software regression in
 d0a0a511493d269514fcbd852481cdca32c95350
To:     Leo Yan <leo.yan@linaro.org>
Cc:     tmricht@linux.ibm.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, James.Clark@arm.com, nd@arm.com,
        songliubraving@fb.com
References: <f15afd38-3628-c57a-0735-1342f379b83c@arm.com>
 <20220714124638.GB155077@leoy-ThinkPad-X240s>
In-Reply-To: <20220714124638.GB155077@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::19) To DBAPR08MB5845.eurprd08.prod.outlook.com
 (2603:10a6:10:1a5::6)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 72536856-f443-4088-fa2b-08da7097037c
X-MS-TrafficTypeDiagnostic: DB9PR08MB7769:EE_|DBAEUR03FT020:EE_|DB6PR0802MB2613:EE_
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VYmB0X0BZzGCB+n1EkZJE5G3Wu0Hdia7ViiBNPyKYufX4Vcgn6KgHevkP/ALd/Z0T7cAgsEKj+NCNoiPVmSp6vwso4gBxt9p4Un8QjKzB//iSgM41Uacwp7jaDFAiyIIk+Jt7Re6f8vqIl7DmpaMS9LSikKnGe7qUwRT1PQrajNJ3fecUei8Rw+V0HtvUOMKoJ8EWN0VaDuBLS694mOIZT8G5pOVlpbt+t58jkHS4uTZYX+Q6KdSjUuulbGksSWmcTqg6uke1Nvs9auFkDFcVenhNvxEmCOLrxuARPT1AN6CrFme/sijs2qLS4TKtFKGpJZCra0hBBGZ/fJAU87ygUhIJMzyrugneD6CpnCopldHyjeyr5+80IZt4hB/LSVF6PH+OS0EeyROjrx1GsbCnSm+q60DViIo2E477lZDZklBMaAjec2+gwnj4M9IwTaf4Rdq2eynxy+sIPIIQkSDVOSiNZ7txBT+JS+Kp7vhWnjyM43xboz0mgPEhTMKJwpC5TLvDi/9q4jmPEr40aW0UBXgC1EMCHP2wECB2WHSI7GyHzl1dzAwgzd5MKmwbeD6xpoOeDyUZvAbNU49T7abaK81qWLSHTLi0QBuxH4SzBHLcDs+qqB8Njg8cSWytN1ri7Rjch/Ze5+cR4nVN6uWXkYQTnq8Zz2Kj3+Ns/Qb6Rfaq5cO+/VtNBq9egyVhXuGIwSsEZSXye2e2kmb5hk/mK872urpZ+nm+def64AAh7Zeci2fNSrCyfRKIbGjON2YnZCHaIH6tPX+uN7U90IuryMtg6sWHfujShbGV4N9PaVKryp+Sb+1OGpn93kYdAGm2tScr7lpyGGrLrMLr2QQBQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR08MB5845.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(6512007)(26005)(41300700001)(4326008)(38100700002)(5660300002)(6506007)(2906002)(53546011)(8936002)(83380400001)(186003)(2616005)(66574015)(6486002)(478600001)(8676002)(66946007)(66476007)(66556008)(6916009)(316002)(86362001)(31696002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7769
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa04440c-c366-4296-108b-08da7096fb1b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r4Fnx5hM7c0Z4orGLkpC6kOOSJ4Qgd2/mXafAaIFcS2j3UFBoYYeQbDM9+uzt2Yp6Fc+wV3Q/NqoDdIZrM+/I/Uc81bIqWNOc6qXABs4HROFFMCxWBaQ9q9UOd9FKjrb2rq25TnHJYybYyZlGSJmXaJb4Pvt5NQocihDYraL5Qg9tNyDFSLzBLOEmE/AsFE9jCoT2Fe7mWHWf5skDX/cdZFNtaKYQlIGYIS5JN2ETfB9/EokFEP99AhHMxlNkPp6hYeS5+aUV6GJXexCLvq5H7CqzsNwhXZ0WTHhT5I7Fse7ylqpEQQi9oXoER2XD+GmCtTj2UJFDrzoaK5RpQnbf1Qe1G3Am8VHoMTnpsWBCOnPNPVyKqoZwmhaXJdBtEre86Sc+yOCEC3+0QFN3WvyYYHkzlzOAu+qDT2E7WV8a29ZkgXH9qAPjpEQTxEE7CK08nu/0I3PBA7WssOipth/A3kr0cwbBuBWZa264u3fqfLr/+SP7dkBCyuBZYh4GliDseltUxmnmRKJ76NmguVZZ/ZemNcDUXujQqEDQWJfjXg+DmvU5kGuXf/R4D5gl9MFG6dpjAfcoGejmF8mHAecs7smKWbhi0YvZVztu8rBSOPaQW2J81meWU0oeGjGRXVGPpXSlgjcpK1Jt+L+/Xb+icSYCdECJnx08d4SkWzZ5oWXJqKMO2NEWZcyA34MCPPKaZQff8mp2jFhjfsUC40wo9i7VH7PoqCeQ2dI2Ulb/gzaPsOx9WZgEigITqgg6q2sbUlICl/HFEOZNq6ZIAocbewrerlAiDNvJyhBxOStW0w36pChqWGwnu2zwhmgl2b8QZQhEWLzSTENXIiOlNY7Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(478600001)(8936002)(66574015)(6486002)(26005)(53546011)(6512007)(316002)(336012)(6862004)(2616005)(4326008)(31696002)(82310400005)(47076005)(40480700001)(2906002)(36860700001)(41300700001)(86362001)(31686004)(83380400001)(82740400003)(356005)(36756003)(81166007)(6506007)(40460700003)(70586007)(186003)(5660300002)(8676002)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 12:45:12.7241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72536856-f443-4088-fa2b-08da7097037c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2613
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thank you Leo.

I think the source code fragment in perf-record is more readable 
(logical) than in perf-stat, so replicating it would be better, also for 
consistency. I have prepared a patch for that which I will send for review.

perf-stat differs from perf-record in the presence of BPF counters; 
these are enabled inside enable_counters immediately, independent of the 
delay; I respected that behaviour, but if it is not a problem to delay 
their enablement as well, the code would be slightly simplified. I have 
added Song Liu (author of BPF counters), in case of any comments on this.

Note Thomas issue arised when using "-a"; without it, events are enabled 
on exec of the workload/command, so the instruction he mentioned would 
be captured. The code structure in perf-record, and in the patch I 
prepared, relies implicitly on enable_on_exec; I tried to clarify it in 
the comments.

Kind regards,
Adrián.

On 14/07/2022 13:46, Leo Yan wrote:
> Hi Adriï¿½n,
>
> On Wed, Jul 13, 2022 at 08:30:37AM +0100, Adriï¿½n Herrera Arcila wrote:
>
> [...]
>
>> I think there are two behaviours that are valuable to maintain to enable two
>> uses: (1) if no delay is specified, the program should start after counters
>> are enabled, to prevent the unexpected behaviour that Thomas fixed with this
>> change; (2) if delay is specified, the program should start before the delay
>> is engaged.
>>
>> Two possible solutions are: (1) though conditionals; if delay > 0, start the
>> workload, then call enable_counters, which will usleep for the delay; if no
>> delay, then behaviour as it is in v5.18; (2) replace blocking usleep with
>> asynchronous callback, if that exists in Linux, that enables counters after
>> the delay.
> If we look at other perf sub tools (like 'perf record'), they uses
> your mentioned solution (1) to handle the delay and enabling counters,
> based on the condition checking for 'stat_config.initial_delay', 'perf
> record' enables counters at different time point.
>
> Alternatively, we can start workload based on the condition checking
> for 'stat_config.initial_delay', so we can get a below patch, this patch
> should can fix the issue, but the change is a bit urgly for me, so
> welcome a better fixing; if no, I will send a patch in my tomorrow
> morning.
>
> Thanks,
> Leo
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index d2ecd4d29624..046686a7c8d6 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -970,10 +970,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   	 * Enable counters and exec the command:
>   	 */
>   	if (forks) {
> +		if (stat_config.initial_delay > 0)
> +			evlist__start_workload(evsel_list);
> +
>   		err = enable_counters();
>   		if (err)
>   			return -1;
> -		evlist__start_workload(evsel_list);
> +
> +		if (stat_config.initial_delay <= 0)
> +			evlist__start_workload(evsel_list);
>   
>   		t0 = rdclock();
>   		clock_gettime(CLOCK_MONOTONIC, &ref_time);
