Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE2DC43334
	for <linux-perf-users@archiver.kernel.org>; Sat,  9 Jul 2022 12:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiGIM5g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 9 Jul 2022 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIM5g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 9 Jul 2022 08:57:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69C4E634
        for <linux-perf-users@vger.kernel.org>; Sat,  9 Jul 2022 05:57:34 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Y42RgvImo8rXjGgZ/aDNFJo6OlDZvbNR8vBUBfsn8vhi53zIpx/Fcbn4PvtJKM6OJPyRfFJI3xohFi5vkd0XkXi3QHuZfeIG3OnzSxfRTJRyDi22DfbALssTNkEjQnx/J+0DRnMEOG82SSlFX0QA3IcRCwV0EnzLVJpTWu8gP4ehiG2/0xR6sLo6cZGFt0dwVEWx/TKvX407wpT5+H1FPBD8gd7K96XU2WcqpHMttHdzxQ4GyQo9XXtJLFBcGaYt7+9tqJiqmyjnbCZWOjneyhsanf87EWqUsGpgy/0VSMS+juoJvYVttIm/oXPVN5OqSaNCW86wQQy6NEO2WiFXBA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mYm0nXCOkSPl63PjZyDCT14QTwqHf4/vsUD6Hc6e2k=;
 b=UzX0hWZIOiOJsYFSxLWDSDGPflzw9A53wbq4YFSj5TdBnFS3ra7NNYjbFMiUNQmxc0Q8FkztIfzqkiu81aLJGVYhN8vrEYgNhD7n/4hv0BhGwEPOMuyzraVpFkK9/4ikwk34qA/hY2HXXMK9hBF90dNDt0gyGY20uy0Qush14Uh4w7Z0Y5vWETmubim+w6qIjYBYkLEreRHQ12F3gCoUS9a2p2ImgXo3BJlf0IMEcB+p4PKjWLv+V5qmPBfeYn4/sb30+liOy/84QOEXvCIkOdSsHJ96zu1WJVlQo1QRD4Y+I7U6afTxNML0ijYljk3BzDeT7BPiV33R75Cbi5/4Hg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mYm0nXCOkSPl63PjZyDCT14QTwqHf4/vsUD6Hc6e2k=;
 b=ENIF6tz4C7AbA5rpe23U9zCsCnaFLZ1qI1DT1s5jPCVYvdoFGlHO+a2bIxHh+wib1Ws82PrWgkhf/+xPv8xsRSVtrta21xlHWcL+gXIN1wOR5OebxezkQx3rLugg6MVmjf2U0IFSpzuc2ZcP2nxp/m7oRiWyPaBfytg7G1l/JVg=
Received: from AS9PR06CA0515.eurprd06.prod.outlook.com (2603:10a6:20b:49d::7)
 by AM6PR08MB4262.eurprd08.prod.outlook.com (2603:10a6:20b:b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17; Sat, 9 Jul
 2022 12:57:31 +0000
Received: from VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:49d:cafe::4b) by AS9PR06CA0515.outlook.office365.com
 (2603:10a6:20b:49d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Sat, 9 Jul 2022 12:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT036.mail.protection.outlook.com (10.152.19.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 12:57:30 +0000
Received: ("Tessian outbound 190453a6d737:v122"); Sat, 09 Jul 2022 12:57:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e864767c8cb1f046
X-CR-MTA-TID: 64aa7808
Received: from eea507ab861a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 071B3FD0-495F-46B4-9A75-48E82BDD9A94.1;
        Sat, 09 Jul 2022 12:57:23 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id eea507ab861a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 09 Jul 2022 12:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX+Yfa3OgIfor90eXkZwB41qEnIFzNjPPr355kzFh7baqTI1AqP29WN0zy4bkeu+No9ToMviezv/J1LNCPBDbrZfDrE3NgdJuWQkA7REsYZJCN0QSrS1N/4P9oBLEzRWdeDTdHbA2ng4SGa8SeK2912jKjG/RxnUzdrHvpJGxbqGY1eORxPehA9T5lhr8y36RldWqp27cwzej0iKLo0PZSJ2JpE4PY4bJVMhkPndlx91w4ExXV0dkKgvob0O6bD971PnVs+ECS8nagcFLzTm35bquCn9i67NP+0SLekLjCkMP8zA39Sf80hp78HBWH8m9JDToUf154E774v/BZ2RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mYm0nXCOkSPl63PjZyDCT14QTwqHf4/vsUD6Hc6e2k=;
 b=m24s+O5Un+ODzG2LAQFw1iMipVN6EvQeZ4kO+qvPY/OnCNlvHqvPUsWnq5YNoG/wc9HMTlu9cZLa/Oh90neu1bOeiKnPulKA5CZLendOhxNWh9Vv7MvyEg6R7KSyPCey4o0SBslsHeJU1XMwBqLaKhZmoUE8zBjDibsEd7yiFtY3iGtHLjRZ9MOgQ8hxhzCVwqXhS9ap5UrbeC9baERMVXsD0RV2RW+BGJbGq6QchfidBHd6tK7zqU5llpjePUVOgOVuRBJvrwD3fqsi2TYx994PvroulXSeEcoq0Bp1A+HhRdJsKj+2xSQshgaJk8Ay8qWRt7MU59ulmpOHqmXm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mYm0nXCOkSPl63PjZyDCT14QTwqHf4/vsUD6Hc6e2k=;
 b=ENIF6tz4C7AbA5rpe23U9zCsCnaFLZ1qI1DT1s5jPCVYvdoFGlHO+a2bIxHh+wib1Ws82PrWgkhf/+xPv8xsRSVtrta21xlHWcL+gXIN1wOR5OebxezkQx3rLugg6MVmjf2U0IFSpzuc2ZcP2nxp/m7oRiWyPaBfytg7G1l/JVg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DBAPR08MB5845.eurprd08.prod.outlook.com (2603:10a6:10:1a5::6)
 by AM6PR08MB4294.eurprd08.prod.outlook.com (2603:10a6:20b:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sat, 9 Jul
 2022 12:57:18 +0000
Received: from DBAPR08MB5845.eurprd08.prod.outlook.com
 ([fe80::8c21:3f27:579a:b7bc]) by DBAPR08MB5845.eurprd08.prod.outlook.com
 ([fe80::8c21:3f27:579a:b7bc%6]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 12:57:18 +0000
Message-ID: <79ea0921-8b3e-c501-7232-8a5c8d5e3ac7@arm.com>
Date:   Sat, 9 Jul 2022 13:57:16 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
From:   =?UTF-8?Q?Adri=c3=a1n_Herrera_Arcila?= <adrian.herrera@arm.com>
To:     tmricht@linux.ibm.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     James.Clark@arm.com
Subject: perf tools: software regression in
 d0a0a511493d269514fcbd852481cdca32c95350
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO3P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::14) To DBAPR08MB5845.eurprd08.prod.outlook.com
 (2603:10a6:10:1a5::6)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d6cef4c7-7dd6-4c10-7272-08da61aa9597
X-MS-TrafficTypeDiagnostic: AM6PR08MB4294:EE_|VE1EUR03FT036:EE_|AM6PR08MB4262:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8LLEo4LxkXQtFce5VjrgnBSIuSql0/Hbi/M3OKZagFjk6ZKpNDqU1yRUITgYZRaOmpS1rHapV5n3jAolUdEgkPOiGnsATY3SldISSoH3DlWn1iFAwGrRadSJEiRYOI3I1oSJNQPcCk1blbOtdkPbEYGiAaTMPOsdNfSoTJSflU1dObHy6Fr1U6jw3Wv8BcE8Xb3IbBBoMksxNyEn+K3VNRUw5t6KLKLJ19VYOERV/HKInXCRP2im29dj7Pr54sFinC/mNnxbgZ3X1x7bKi3IGE7WXYMAUdFyFgj0ynTjNlmwY6cSK5WRppClHhITsMnZZXfIQ8Z7CLp7iG+8R71gKaQ/h0ZKn5SFyNnXIdVzzc9S1jq+Fqktodg+WqSIR4ANR1arjbPd54NVQZMaMKNaRFsxmujn8q9sEvuoRtwPWD5q6oB+hDDzvdBJ6lASKmP0kSVFAIDT81sts1DHKcsr4TskwgM+aDrAgGqB2cU0W7iQBLHuKKXzN7gim6UOr6THh9zPhuVSe9yKSQ/+ojeDtzBc++lBPB4CwYW6yh4tkGbjdZIy6pgqC/CgLxhbvSIWbs8Pv8lx26tf7CNqeU7gv1vtK3ge16Mgtu9wTTbICKliw1oc45jJapujHgkr624wO/N8noBmWsj72jVHyFQhaT5GOop0EVHYkFDai7nsqhsQjrZbOU8A7L65Nad9VzQfeauy/MdaHLA0WEp0VA4P4gH0m7IVtJI4EU6OtJ9Jho8YBdn2CGKCYqaZ6+8f3l+DqMqlywHTWK1n4Jd2EI0SgGxvW5Q6Nt47Z8vT2Cul2S8WHwpgisNZ4RTnq2/EKia+2a3c3kQ7UdkcQrDPI2Gio6THqs4jifvrq8P30o7siPAkz73O1ZLQUTsCGUWNfXqz
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR08MB5845.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(2616005)(66574015)(6506007)(86362001)(41300700001)(186003)(31696002)(2906002)(38100700002)(31686004)(316002)(26005)(478600001)(5660300002)(66476007)(66556008)(8936002)(966005)(36756003)(83380400001)(6486002)(8676002)(66946007)(6512007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4294
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6e508c4d-f542-4234-7fc4-08da61aa8de1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnmlhZLKWaKZUyqG/TcA31xZsHHSWagAY9CnNizWZ6VWaLDtDsy1waLYV0fni5cTDsiJkoC4CiTH2+V6Ov5SPFckK2X2KgNPFXgVF2KdMfUQvXC855+nPoXMR9e9UyqmijNm7aKeWpbJk5jEBQh/6GgtESgYWa1phxObv9vNonxUvoi4yiZ4+E3KLupF40YCDwG35hgSmTjh/0Dg+ndPhCG7T+s0xT/bP7GskqNDf3FoWesLcmWrrTRC5I+HdxLN0KQPYe6922fZZhlBPtX+O44I5j0+ONi1O1njGJoVcEAispmn0n3Qh9+sxEtlg7jg/6rADjRzNRi7KlQPAMRNXaMyvk4dJMF4upblZtkc41+P9j/AnyrZE/ghtUtsrxBoqo95wSoy10TjKx3/s8ZaoISbti/3741jdAKyBrY9mtKh+twQvvr4l+3bVgzsNXfFdAcEiYWvg1E63/axX9eNKMcxZiYnD7SoK1Lz4ZI4xDGpaykRscZ3YbVWjUFfipmI4q5mh3ekvL4FgqcRIPeqcBXrb6p6oIAtymf9ZuYm+bDyU2u239jTqSbzh3V57zOviirMM2Aj3LosHQi1+YnZV8DwD7fpo3Keufi383nzuwUmDLSrkDiiSLML1r36SsrnhFkA6W5xBeVv6ccK73msIg5YY4aCvIMy3irQB+2kGw8YYNL8bVJWf4zCUa5cugx304BcYqwTs+mqTKUuWfCW0F4BvU1jJDpmLn1dtqYcS8/i+ayfwXq+sN+5S2p37+BpgXX+DsCJP+PmY+wI9OswOO0HwL3rYhaR0P9TjBdbwnbKfeWyyeY1dXj/2VXWZ40E6C6S0IVOozJ4Aam8hHMhAqVc1oz0iCMTK3TIdUEvOM9chrqeiv4yBv9Z/KNGDLd8
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(40460700003)(81166007)(86362001)(6486002)(966005)(40480700001)(82310400005)(478600001)(41300700001)(31696002)(6506007)(31686004)(36756003)(316002)(5660300002)(2616005)(6512007)(82740400003)(4326008)(26005)(356005)(36860700001)(70586007)(186003)(8676002)(8936002)(70206006)(83380400001)(66574015)(47076005)(336012)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 12:57:30.7348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cef4c7-7dd6-4c10-7272-08da61aa9597
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4262
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

real    0m4.065s
user    0m0.019s
sys    0m0.028s
v5.17 output:
Events disabled
Events enabled

real    0m2.028s
user    0m0.001s
sys    0m0.008s

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
Adri=C3=A1n.

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
