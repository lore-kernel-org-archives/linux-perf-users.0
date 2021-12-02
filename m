Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C0C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359304AbhLBQEM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 11:04:12 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:45039
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355540AbhLBQEH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 11:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYpT+sia1BaOFYJyVnV5+IT6vSfkKT549ZX3f4eDCPE=;
 b=ulPn7Q8SMGZfCdYS9yc4ORJTrVIkH866978pbIvx9IJIZ2W7v+4IxVKaFpuvk1V4YeH+MOAs2AKZdSKAKFKPrIe3EXt5v6Pk0uPW10s44sAw+vMDVUv6jqzKBO3LhiaQL77ot2GSXTBYQTwO8J/2tHSOZY4Y8I4k3mjP5mip4rw=
Received: from AS8P251CA0015.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::14)
 by DBBPR08MB4313.eurprd08.prod.outlook.com (2603:10a6:10:c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 16:00:39 +0000
Received: from VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::c) by AS8P251CA0015.outlook.office365.com
 (2603:10a6:20b:2f2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 2 Dec 2021 16:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT008.mail.protection.outlook.com (10.152.18.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 16:00:39 +0000
Received: ("Tessian outbound c61f076cbd30:v110"); Thu, 02 Dec 2021 16:00:39 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: da4b1d5cb54afb6b
X-CR-MTA-TID: 64aa7808
Received: from b3a3c2fd9854.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 323D7777-A8D5-4F48-A0CC-12C88263BF6F.1;
        Thu, 02 Dec 2021 16:00:28 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b3a3c2fd9854.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Dec 2021 16:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVX89MS+eqlXvNXEP2jLtUGzpHaBhlDaAzQxy7OW+dxFz+zi/drXrhB0mXnHPqH61KG8oMFr+InyKm4eTQrkiVD8D2eiwSSDBHsPHONbnVQhHsUZbi4Bt0MTYYKfENwcM29s8/ogoi2B1ml+sNeSSLrBzRdtPHA9/nfuWhohCaqSm9zRiNsHUIx5gvyUVTipFoj5o0UTiHHXuHV+5Td3ZkTsmhCt1WLSedPgpcc6xJARZwx4h8x8BAlIB3+HuRDVcY3ZKJDmcd6XwxW1d6IPJGcO228QeQTQaPOyp/QIBU0e2fwssBWb5JlwCljKCOJYQMIrYAKbgjo55wLnOpFaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYpT+sia1BaOFYJyVnV5+IT6vSfkKT549ZX3f4eDCPE=;
 b=J6clPaorkZ8zZm26wqIt5jSEbT7IUPTHj2Gq+vPfO5opgVyabKkqSZCVcYSXIIaNaXi9fmsQ3PQntTV70OekuKRBavsxsulUV8WMBJsb66jn+VugvoUbTxThjs6p2lMZcCKP6IHWosXYO7m/URgq0JrLS3Qza/Y9e/U4oBI03lgFtjgj5lSuO8ReWRNJLfrUQD/eOcScFXO4TKiNQdeWNmII9K5rtEEfR98hsJdZ0cBwQtQobNSaCOYE22XBrsa4tRHjyYJ4kS6RWDpLy1disDhg5PJZuTPL5XKfWyNQpqIfMHx5cMaZnEj0qGD6XcXTzVIg/kIxqbQiEpzTk3AlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYpT+sia1BaOFYJyVnV5+IT6vSfkKT549ZX3f4eDCPE=;
 b=ulPn7Q8SMGZfCdYS9yc4ORJTrVIkH866978pbIvx9IJIZ2W7v+4IxVKaFpuvk1V4YeH+MOAs2AKZdSKAKFKPrIe3EXt5v6Pk0uPW10s44sAw+vMDVUv6jqzKBO3LhiaQL77ot2GSXTBYQTwO8J/2tHSOZY4Y8I4k3mjP5mip4rw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com (2603:10a6:20b:29c::13)
 by AM6PR08MB4916.eurprd08.prod.outlook.com (2603:10a6:20b:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 16:00:26 +0000
Received: from AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::384a:1596:2b3f:38ac]) by AS8PR08MB6069.eurprd08.prod.outlook.com
 ([fe80::384a:1596:2b3f:38ac%9]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 16:00:25 +0000
Message-ID: <241b28ec-4acf-b30f-90c1-e1f7ef6c1443@arm.com>
Date:   Thu, 2 Dec 2021 16:00:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
 <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
From:   Branislav Rankov <branislav.rankov@arm.com>
In-Reply-To: <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::9) To AS8PR08MB6069.eurprd08.prod.outlook.com
 (2603:10a6:20b:29c::13)
MIME-Version: 1.0
Received: from [10.57.33.249] (217.140.99.251) by LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 16:00:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b69882fd-9d85-4ac9-ac42-08d9b5ace2ef
X-MS-TrafficTypeDiagnostic: AM6PR08MB4916:|DBBPR08MB4313:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4313B8E6A1FEE8E8F99784D094699@DBBPR08MB4313.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /cBV0aZMmdxW1KnC1NTbfYfsoR5UbppIZhzdDCgzbp5kjpyGaO8EXiBTsDRzFWy8yzhCWH87ESgxcOkq5XKWZNmehpS5mcOYT2Hkgqhq5GE3SBQVlslWYHQ5uuHAhjpO9Bt9+eCFWNsuRTUhqwU7khi5FwWM6DUzDSgQCVrZENwSHhNV7RozQyRZPK+BQFP8SiS9wfrUxZxErgCvArzk/vCcwpdyZ3RI4Q7e+avs+ULmQ9U90nJI9xZI9EaND0WXlVe7R+mNAS7Pq/0C6chZhF5b61x+8HexU//mzWmRcESKEQ56/c4i/stAa09iJbk9Yp759HE4DybBA5E6PRC4OdAqrfvnAD4s/jFm2p/L8i0rexr97UbiCrODTQS4FTXDRt6xMyI81KydEdlDAxQXWuXV5DZ/Vnfa7olW3Si8NOe8JOLm7oFDEQMnU2Po67YjbWsO+lhVKBMEF4unr4FwYcCMQ0mbEitYRKhi0pvHuRohXS3bz0x4ZW6tsnUwlcoR9/cpL+JFmmOjIlQYmgFaa4zJ6r4TWBnfNssMSMe0bYTaFZM+0GNBM6Cht7Zex8hC13RjOeXFhzc76PubDBysaiNdI3lSBlqidOXzOQMv1h1HPX3XIx7IJMfSUmyzk3CH8k4GSty3U5Y6JcGnwLwJr7ruM89pFV8NU763/N7Z77Dv6FoZeLZHIuKeoRZ+XV0xOL/ejqodnfEnnVD3m5RTkmb6X8KRIL8poD4S2nVc4lg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(44832011)(6486002)(316002)(2616005)(54906003)(7416002)(66946007)(8936002)(36756003)(5660300002)(16576012)(86362001)(110136005)(66574015)(31696002)(2906002)(8676002)(53546011)(186003)(26005)(508600001)(4326008)(66476007)(83380400001)(66556008)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4916
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4cbaa74e-0c47-4fc9-34a2-08d9b5acda1e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByDJrr6lvfvwI+MkCK2iB1SazJH9MZn2OYDdKrgo78obYFmqfzphkNtBzImp2yOTKbVljzkwKoE0ypE2/kK+PRtV5aDMUuwQm7AvMnv6/SpdF2Ee142XI81GMcd/+glVDIkxr9hO05tTiu6GJLrJFjk7HCR5vZva932qi0H0xTS1iUL/ZiYbcGNpZfO7QgXGYCbQ/oa7c34vxHDIsAGE+o9fnr6DIj/LtMRTtLMQtnndvofRv0CNUC5gkO/zYf5aVy/V51iYe5gxomxqT6M5vIcNM44fG0fPYZSGH+TTH9LtO5lO9VieMaci6Io+hJf8i0RVFLnY34Gn05mHc30XfD1CcvnGbboMZObBg1TrHFMFBjujxjeoE9rxil3Nnu11BnI2f6K4+qD6+2G9mi9Zn1MzXjyxWgBmc7PEdL4eqxbjn4015NUlf9FlYl04CEk6PYVhmUh1lq5VCZ8HnnnerQSpBUG8baGFR8RhiYJXZDRF8xvdTlmxhjG0t+f8jLwGBGyH++kFKIiPvELaDsNpD9iZrGqqIguSUSmMbLiqLndLASiUVPU7i0avGqKlRW/YZkyL8aMFkVr3YONHRoVmCqP70fvCzZWCa0VbaoQKINZmmPlhSOqV0sm/e2SyWUV8bwZ3GWSx11vBMMKVC7VaaJ2DZmI6WIrrd+f6+457ug+wVc7pHV4m1qWh7B1xM8A2JUY9DAjapqAij19x8CTVINu8yfKkm9uJgeH3SygAx38=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(31696002)(47076005)(336012)(26005)(66574015)(8676002)(83380400001)(508600001)(44832011)(70586007)(81166007)(4326008)(5660300002)(36756003)(6486002)(16576012)(70206006)(316002)(8936002)(86362001)(186003)(53546011)(54906003)(2616005)(36860700001)(31686004)(356005)(110136005)(2906002)(82310400004)(956004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 16:00:39.4902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b69882fd-9d85-4ac9-ac42-08d9b5ace2ef
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4313
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/2/21 15:36, James Clark wrote:
>
>
> On 02/12/2021 13:43, Uwe Kleine-K=C3=B6nig wrote:
>> From: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
>>
>> When cross compiling on amd64 for arm64 the build failed on my machine w=
ith:
>>
>>      Makefile.config:493: *** Error: No libopencsd library found or the =
version is not up-to-date. Please install recent libopencsd to build with C=
ORESIGHT=3D1.  Stop.
>>
>> even though libopencsd was installed (for both amd64 and arm64). After
>> some digging around I found the relevant error message in
>> tools/perf/feature/test-libopencsd.make.output:
>>
>>      /usr/lib/gcc-cross/aarch64-linux-gnu/11/../../../../aarch64-linux-g=
nu/bin/ld: cannot find -lstdc++
>
> Do you have this library installed for arm64? I know you said you had Ope=
nCSD installed, but
> maybe the arm64 stdc++ lib is missing?
>
>>
>> Instead of fixing the error message to also include a request to install
>> libstdc++, just drop -lstdc++. With this change the build completed.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
>> ---
>> Hello,
>>
>> not sure this is a pure cross compilation problem. I think in general
>> it's a bad idea to link against libstdc++ explicitly. Still more if
>> there is no C++ involved.
>
> This -lstdc++ was only just added a few months ago by Branislav so I'm
> not sure if it should be removed. OpenCSD does use C++ so it is involved,
> although I would have thought that stdc++ was a dependency of opencsd so
> it would automatically get pulled in.
>
> @Branislav, what was the build error that you were fixing with the recent
> change? I checked the commit message but it's not listed.

Hi. I was fixing the static build with this. When doing the static build yo=
u need
to list all the dependencies. I thought it would not be a problem to also l=
ist it
in the dynamic case.

I did not have problems when trying crosscompile in both dynamic and static=
 case.
But maybe you have a case where this is a problem. I would like to understa=
nd what
your case is.
Does your libOpenCSD.so have a dependency on libstdc++.so?
If so, where is the libstdc++.so?

If this is a genuine problem, we could add -lstdc++ conditionally only for =
the
static build.

>
> James
>
>>
>> Best regards
>> Uwe
>>
>>  tools/perf/Makefile.config | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index afd144725a0b..dc946b7a802e 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -143,7 +143,7 @@ FEATURE_CHECK_LDFLAGS-libcrypto =3D -lcrypto
>>  ifdef CSINCLUDES
>>    LIBOPENCSD_CFLAGS :=3D -I$(CSINCLUDES)
>>  endif
>> -OPENCSDLIBS :=3D -lopencsd_c_api -lopencsd -lstdc++
>> +OPENCSDLIBS :=3D -lopencsd_c_api -lopencsd
>>  ifdef CSLIBS
>>    LIBOPENCSD_LDFLAGS :=3D -L$(CSLIBS)
>>  endif
>>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
