Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71047C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Jul 2022 07:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiGMHbH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Jul 2022 03:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiGMHbB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Jul 2022 03:31:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628D9E4F3A
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Jul 2022 00:31:00 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=dKrmPNsSjbwc6HB5Io/mZeWP044eaJt4NkaEFU09N0X8otpetK7cBRS0L6iUyBkTm6cyrBDg7+U87uNyz65UZS+tR1S/8/jHsgxpV03fkTt4AomVt+VSNRE2KxHfXer71+5hLicUKjNWuIMuCSgIMhZkwyh052xlyGZ5/Dai5geMmiEDaWwKQxshdrAGI1M1NaOlH90cfh6tkxTVi+CS2gtESAxxz/wpnmh99++5UafPuDCbiOZXrsIo/XsAi1xppRw7qz9yf5Ou7eLXaUmkY6iN/kXRsDDPBP/D3NRsokvzXUDW+ua/CQXysqpFE6Ol9JF6vvZ9AsFR3s8NXso/zg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPlIXr7nIv2Ff0AhLZn58xnzuCNTG0vNtLr4Z+1lKmA=;
 b=C3LBCaq4uZ4BkCfg/yfwXUH7c1s+KvYBpvtPojANS0XUxrqmSKD2B46mwp2c6XIL20KDmRjyXi2LOL+8wnVfqr7KCNvWzcyi94PGHcPCgYppyhpQRXPrudKo5/Gf/Mo45xKy2NwDdHJfasx//NS14R+iR7+qkKHrxm5iOXUMiNFf+79SA+LNkhMxQljIWsbOIn8AfNeHCNX3+Zpqpiadi9Q8NwVGHHBt129iuQVDth2C3iBOpqUzDmWQOU86ykw7JzBTlJ5nZyEx5507B+JSLwAwNhxNO5W0mi4h2H9zc7o91ZMxJKERczrF0CMPgfbokkpxmxzVJ/ZvliPVDk9Agw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPlIXr7nIv2Ff0AhLZn58xnzuCNTG0vNtLr4Z+1lKmA=;
 b=ONUgwwNsiZ5doS5GHHR4D2ApXxO8Sxd6Q8IuTMq6bzPnsI1Dk5iIpTt9F80YgSpBF5WRqWmnwFvcXm5XNFA/5GPadYOuWt1fQG8p2ORF4QuhQj59zQOwtPT9o8NcDa5KKWxWkOVeiYAjHWtDrudZP+vecE2Nmoqq1ZLjYFr4pRw=
Received: from AM6P191CA0075.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::16)
 by HE1PR0802MB2603.eurprd08.prod.outlook.com (2603:10a6:3:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 07:30:53 +0000
Received: from VE1EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8a:cafe::f) by AM6P191CA0075.outlook.office365.com
 (2603:10a6:209:8a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Wed, 13 Jul 2022 07:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT006.mail.protection.outlook.com (10.152.18.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Wed, 13 Jul 2022 07:30:52 +0000
Received: ("Tessian outbound 8e3d5168572a:v122"); Wed, 13 Jul 2022 07:30:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 201b8e6d458ec4d7
X-CR-MTA-TID: 64aa7808
Received: from 663e55385e1a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2C9C4D66-690B-474D-A7FE-2C55248265F0.1;
        Wed, 13 Jul 2022 07:30:40 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 663e55385e1a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 Jul 2022 07:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIhtW7TrC9ePKwUdlggscMmBah7dUxu3nx2TPwRxtZxvYKzKS3+vbKf9vuXRaOckC2ILzJlx6DkxV/lzVHJA5DsXxavyn0ztSmb06+U5A0eIEtBOK2aMVEE+Ez8rDhE363LsCOan0D7hhziaFn8CrL0JqRGikWXSTapDxEec+hZAiSfcltyBZHYZ4rgS44GUOfaTX80HpvhgFjj/f5zuRZV96VGihjyPrVp8dSDmK7bJYQnekIogcjg8nplwZXR14yjcHhhw2lOvY3tmHIAyrsie5D5V+/JYO58DWVRxBfgcKei+9j8DHxQ8en6ZaTsWQii6HDmZMHRT6i+ydHszag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPlIXr7nIv2Ff0AhLZn58xnzuCNTG0vNtLr4Z+1lKmA=;
 b=bN5GfmCsnDn/r7qmRgvnwh0tS3h5lqBzVqFl4h3NmMbwH9ebxn3Kbej8ib4kX9iBTwYxpihiv9z/XdHS9+X4j+gKhy1qo+tUTlP+LzVWB8ujdihRHpGsbRNVZsajg6wxdqsxOlAyF+F0tYGDNhujvsoSv+VQBTSgSL3PmOiOLW15O6damdYnhMd4vyQ7ExhmztCJMGIYsV9n58zb+oA6yZ/rMzT67B2+/NQVpY3FcRv6NNRnbZAZ0+oYNtfcoz99434BKp3TNzqlB0DYevKhazSnTbgE/M5FaPBVqBD23i+NOtcil4MuFe7xYeA6rXGBH35uVxeLWbSY/4qgxwRfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPlIXr7nIv2Ff0AhLZn58xnzuCNTG0vNtLr4Z+1lKmA=;
 b=ONUgwwNsiZ5doS5GHHR4D2ApXxO8Sxd6Q8IuTMq6bzPnsI1Dk5iIpTt9F80YgSpBF5WRqWmnwFvcXm5XNFA/5GPadYOuWt1fQG8p2ORF4QuhQj59zQOwtPT9o8NcDa5KKWxWkOVeiYAjHWtDrudZP+vecE2Nmoqq1ZLjYFr4pRw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DBAPR08MB5845.eurprd08.prod.outlook.com (2603:10a6:10:1a5::6)
 by AM8PR08MB6372.eurprd08.prod.outlook.com (2603:10a6:20b:369::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 07:30:38 +0000
Received: from DBAPR08MB5845.eurprd08.prod.outlook.com
 ([fe80::8c21:3f27:579a:b7bc]) by DBAPR08MB5845.eurprd08.prod.outlook.com
 ([fe80::8c21:3f27:579a:b7bc%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:30:38 +0000
Message-ID: <f15afd38-3628-c57a-0735-1342f379b83c@arm.com>
Date:   Wed, 13 Jul 2022 08:30:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
From:   =?UTF-8?Q?Adri=c3=a1n_Herrera_Arcila?= <adrian.herrera@arm.com>
Subject: perf tools: software regression in
 d0a0a511493d269514fcbd852481cdca32c95350
To:     tmricht@linux.ibm.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     James.Clark@arm.com, nd@arm.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::6) To DBAPR08MB5845.eurprd08.prod.outlook.com
 (2603:10a6:10:1a5::6)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7763e1cb-4f79-4b79-eb17-08da64a19de2
X-MS-TrafficTypeDiagnostic: AM8PR08MB6372:EE_|VE1EUR03FT006:EE_|HE1PR0802MB2603:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: r+TubbhhG0Xb2Dp7HUxWCgJ+hrmBKV+c4BGTZBnKbPOFuExyj6m02GpHgpYhgMakKZ1yVfrru1xpoXvVFUqHeMuoJpULS/5pwU8HolRtYefW3HeBGPxzZIcq/vbVbCeKUhRolQf6Mnb1ITmGWj2CnvgjvFKxbfnm+JAtdxjSoPn1JtFQZ9wXhm5HdnnF1XbXvAh+pw9G+x1HYJZlWYZ1Zd+8HfmsI5xTpZ0u+XkbPkbwsvHJNAmlFBXnHKd+31CC00SLfD35TnMQw2gjxKI4942JJN1wyuvYwsskBAS2DkbEUaChYPiAUyKUIZnTW77na/ghdYKQ9eZsSKtkYLb7I4rnTgmrL1pWe+3KLTMEClpP6531Y8Z+JIb6dQrRoctr08b9KJLuIQiHmZwDFW1fA9JrClIPV+u1nHyX9u070Ep8pXwB3HCcI074LAaZXQB16lU8x+nmDOXKN08pnjL68N8QTdBc9cZfEKFmVKlqj7G11vv7aSMErVCmEj7Xq4w1P4TnNfrMMabYtr7Kb+qkUWh6WxMPjelHrCNZo4DZUO54fozaIAMQJGjRM8+0GWqVXv1Af4kz97AC/cjfzQFHodrgviH/FUo93EJjjkdaL957UHiPfkFLiY6nh0t+MHcgnA+hRIskYpwEqGfxL5EwPP7UDibDh0oGJYYQpJIgqVumE7kQoOES0yA+Tg6J7LFwfa3UcX06hY7q+Mj28Vbpu/GyEDcwyasU1WxL00yGInw6rew38EgRvUUNPC/ks1MFeDNnk21wfevQsW33fEVQO+h24gRo+2QD6Dyt/RTNlD9UpoBFkfh6/5YH1Z9rQLOrjkFsYloxnhAVI0Gu0fspcRqiRjarNZdWCztufiZVNosNInSpP1EZHbXvTtaqIhvM
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR08MB5845.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(66556008)(66574015)(66946007)(186003)(6512007)(8676002)(66476007)(4326008)(26005)(2616005)(36756003)(31686004)(83380400001)(41300700001)(6506007)(2906002)(86362001)(31696002)(5660300002)(38100700002)(8936002)(478600001)(6486002)(316002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6372
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b33bdc0c-d2cc-44d4-7dfe-08da64a1954c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcaivSWRVSgceANqZhIG3klFI9e7394fc4dnKPOM3epj8fIm3bCXoZmJStcJhUawmFko9+Dp0tkaNr4y/nnY0nQvvNfZq0rU/oiBxncm9xZ8dVZZRYuv4PyVq+mXauqLg/EFBycJW1P45uZNhtjpwxXvcCpJym+MlIG6SFYo97aPmPAi4No+4OypdOomV0ZPjC2n7OuRgW3EDz1HI8gZnSDgYjwqDDxSe1opzq9SeneWderfzVHpnuI8BKka2PrmZ8xp3G9m6fquV6pPhCc+mjpzwgJ2N05FVCw0VW1/1EWQrykD5z0SPpqawSstIlWedweBpMuefsxUSZtVJPadHrUWmBYsQbABpYJzkvb7y2WOyJq905rLSdzY6ZYIGN2cftXDTumDhGgkggjPMSBmo9zvDWtFAlJcm/PQ5e4WTNXm1iU2HStFs7HrLwGo9qS0wG2Duz4waVY+WB3F2y1TeAOOWsIJAHQyvmpDdOmP0JjUHJxR9659Pr8NLxg9PgIekI1X0zv6yklMWj0Xmyl0Je/yzTS875tiaU5h7u87pQ9uUCweWgSrQyc40N5iYc96XFNB39JHnMfuva2IK2HJ22P8X7RUNX6kErQKgpk6i0eR8ouoOxHwu145REkDz2vGMfgV7aVmoVVfzdS31U6ZtM0s+6fzZoSd/2QcnrlUSFVXgRX3FMyip6FrRav1ty+PhbF4/oRDOuArEdr/geIhZq/lvqJ+zejGEREwqeYR25RmJW8XofGKjd5MbcPy/mT0y8gJ3mszWH/b7fWuwvrUePiIrxhse3AFsKNlwjGuAqmljlsrNoufunTXPcKn3hFSdMbZ2XF03IP1ogJSNVatlMptzOhixshj3deh4wcuHwNMIh/PBlUlLD1HmtYFwK4q
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(40470700004)(36840700001)(46966006)(4326008)(356005)(36756003)(82310400005)(47076005)(70586007)(31686004)(316002)(336012)(70206006)(81166007)(8676002)(36860700001)(82740400003)(2616005)(966005)(40480700001)(86362001)(5660300002)(8936002)(6506007)(66574015)(83380400001)(26005)(2906002)(41300700001)(186003)(31696002)(6486002)(6512007)(40460700003)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 07:30:52.6659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7763e1cb-4f79-4b79-eb17-08da64a19de2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2603
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello all,

The regression affects the perf command "stat" used with the option "-D 
msecs, --delay msecs". The change was introduced in v5.18 and was 
backported up to v5.15.33 of 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git. In 
v5.18, the behaviour of the affected option is described in 
tools/perf/Documentation/perf-stat.txt as follows:

"After starting the program, wait msecs before measuring (-1: start with 
events disabled). This is useful to filter out the startup phase of the 
program, which is often very different."

The program is expected to start without delay. The observed behaviour 
in v5.18 does not correspond, as demonstrated by the following experiments:

time perf stat --delay 2000 --quiet sleep 2
v5.18 output:
Events disabled
Events enabled

real    0m4.065s
user    0m0.019s
sys    0m0.028s
v5.17 output:
Events disabled
Events enabled

real    0m2.028s
user    0m0.001s
sys    0m0.008s

perf stat --delay 2000 --quiet echo "marking"
v5.18 output:
Events disabled
Events enabled
marking
v5.17 output:
Events disabled
marking
Events enabled

I think there are two behaviours that are valuable to maintain to enable 
two uses: (1) if no delay is specified, the program should start after 
counters are enabled, to prevent the unexpected behaviour that Thomas 
fixed with this change; (2) if delay is specified, the program should 
start before the delay is engaged.

Two possible solutions are: (1) though conditionals; if delay > 0, start 
the workload, then call enable_counters, which will usleep for the 
delay; if no delay, then behaviour as it is in v5.18; (2) replace 
blocking usleep with asynchronous callback, if that exists in Linux, 
that enables counters after the delay.

Any suggestions from more experienced Linux developers on which solution 
to pursue will be appreciated.

Kind regards,
Adrián.


