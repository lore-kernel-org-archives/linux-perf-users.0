Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632F14AA3
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Nov 2023 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="bms7kDXu";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="bms7kDXu"
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2043.outbound.protection.outlook.com [40.107.23.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0B3868
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Nov 2023 05:38:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHRDFiw5ht1P1v0WIgDnTiN5oFI8SXW1dJ1aADA2jFnC5bRLLsNIJNnWHTkmKSiJHsT3DW2+rAfUz2n/oNxlyJCNkZQ9fRNjrUgUxygAWFFCpSXyiM1cwv6+WpyvaRXvsAfyJd8yRR8LZ+w4SpS3LcWIW0QhLs1D7AxB5RLuE083YTWFSEJZrLg5UqdmgoijA0sRtneW8CNssRG0zYlHyEw26L/w7UcDXZqOWwGkCnpVhObGIfJeLlYyPUhyWE6YqJPLUkVae1hoPyRjkiC0GVg3GrnkhJrFnCcGXtUygiDtMRjT+umBIPU8Qyi4jiF7BVrHMlxECY1GQ0fWHF3ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy6v1NIbz/7KCUE3RMV5lOh5JFkRU15AYOvytFFWcHs=;
 b=cWHmXn5BfcXRML9fKI+3vRk17IfYO9VrPb5JchbfbYwhbPJLfsxVf6t5++ubYID4y+5aBMEZ+lg4VBJ2sdpsoqQpeeRl1xoTHjHsrK6YCa4PCd7nJHqWLUcoChcYVFslvO7NvjM6a9VIvg5930KVM4nsL6hMXJmvYIJg5Z9Dz1YwCXPy7xublhFgLT5gvhI5+jnCgC0KxF7SGf1JatncfbiBTTgXVwWOQo+pxhfiugjR8o7VSIiJ4Yv32V0sE3EOaxgiMGtUjxRJp95DBHNf6eP/njPTCTzOOa07gR2WCwF8af0YQqpytO+iv+Mo7x7XhBa2DBn0YzaBuh6iMvAuiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=gmail.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy6v1NIbz/7KCUE3RMV5lOh5JFkRU15AYOvytFFWcHs=;
 b=bms7kDXu281v2pHIaGBKHqgtz7pKwMl6w4qwiqDrQYM3QDXoTAkLKMl/49Dpw0ogzxBinnztu/JG+0r9p/+Mdxj3qgvIHdHXZkk0/jBS83n/IgB12+WIfhlk1S/rw1yQ8OE1hJ6Lbu9wEldUEpmZsaenkKkv2APSKu6y2YSXrCk=
Received: from AM6P193CA0096.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::37)
 by GV0P278MB0065.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Sat, 11 Nov
 2023 13:37:57 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:209:88:cafe::21) by AM6P193CA0096.outlook.office365.com
 (2603:10a6:209:88::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Sat, 11 Nov 2023 13:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.14 via Frontend Transport; Sat, 11 Nov 2023 13:37:57 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.4])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTP id 1CC70FC293;
	Sat, 11 Nov 2023 14:37:57 +0100 (CET)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 139E9FC20B;
	Sat, 11 Nov 2023 14:37:56 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=bms7kDXu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy6v1NIbz/7KCUE3RMV5lOh5JFkRU15AYOvytFFWcHs=;
 b=bms7kDXu281v2pHIaGBKHqgtz7pKwMl6w4qwiqDrQYM3QDXoTAkLKMl/49Dpw0ogzxBinnztu/JG+0r9p/+Mdxj3qgvIHdHXZkk0/jBS83n/IgB12+WIfhlk1S/rw1yQ8OE1hJ6Lbu9wEldUEpmZsaenkKkv2APSKu6y2YSXrCk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::11)
 by ZRAP278MB0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Sat, 11 Nov
 2023 13:37:55 +0000
Received: from ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d9d4:3fda:5220:b62e]) by ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d9d4:3fda:5220:b62e%7]) with mapi id 15.20.6977.019; Sat, 11 Nov 2023
 13:37:55 +0000
Message-ID: <ed21730f-7fdb-4c1c-a66a-ffbcd5c215c1@cern.ch>
Date: Sat, 11 Nov 2023 14:37:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: long BPF stack traces Re: Broken stack traces with
 --call-graph=fp and a multi-threaded app due to page faults?
Content-Language: en-GB
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 linux-perf-users@vger.kernel.org, syclops-project <syclops-project@cern.ch>,
 Guilherme Amadio <guilherme.amadio@cern.ch>,
 Stephan Hageboeck <stephan.hageboeck@cern.ch>
References: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch>
 <ZU5TZiXMUZ4VLOO+@kernel.org> <ZU5rHB4DCiBqlKtC@kernel.org>
 <CAM9d7cjRBWnFoSkR+Gu8fN_0G6PDLMHRq3rim_Aksdwh8tWBmQ@mail.gmail.com>
From: Maksymilian Graczyk <maksymilian.graczyk@cern.ch>
In-Reply-To: <CAM9d7cjRBWnFoSkR+Gu8fN_0G6PDLMHRq3rim_Aksdwh8tWBmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::15) To ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:56::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1123:EE_|ZRAP278MB0029:EE_|AMS1EPF00000044:EE_|GV0P278MB0065:EE_
X-MS-Office365-Filtering-Correlation-Id: cd502023-f22a-4db2-3e97-08dbe2bb6a5c
X-LD-Processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 QB3sjvuGqewGPXPkNd91+ksSZxE0CFMqPUnsS0E5w9fjfwMaPqNK2okv576l6UFsPq498mYU30LHxGw83Zx06lIw9aFGmyvxRsLUj6T1ejki6dAsQxXVWKmCl6K/WxcSOXxi3f1a26iFMqsXFqEdY9YRONh2zXBFENiL7l95IrprUzcYYMguJi3IvRH6LOgQOmtebv1BnPELOgaqqT4ScZDexXN8/R8u3u0JVdHFbEEi+vy6NUoPqVC8SrnEonKEehprf33hB11BPmHszv8prreEVeuA0rursHwVwHtAsR7Sjbw/DQga0bIGUkf/4mFFLnphXaGBmHl8HYiqZ12Emg/6V3TRquz6eRg88UT7FonPLlPzHcZuJO6RI9x1GG72O8LotJ6rTj3hksDOXV/rvt2GzYfOa12m7/0pfvpVCuDLU4hCeyZZpTvR3v1Z5GTXpi8vedmx/l7a9f4A5vtL7O6G9LlCP+WCjhPBKNtmm9tAc4S6TZB5PUWt9bb/AiqCB3u/maSyCxlwgeEDL22s5WOcDlLOhRQJA9ncwQTM1ls5QbYew/hESBnugxxEgyvwg7OrLCRoN8kzihg2hJNvFtmdwMPgDiO575l+dzDQl3zOwbROiuzn0d1fsiyFbSdQs7iH5C5CetN1AMVJKXNv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0029
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a713800e-0e43-482c-4faf-08dbe2bb68d4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GHPQQAQtWXzPnRSoZZj9cy9G6a0g2O8PkGjCtcrmKqahhgbNeKpffAowH5FRx3eVIGQa2B8ykc7n6gCEPFh57wFpH5nCHja7fAX8i/7ZfMahVNRubaGtzEGU52lgeRgzbUep3v5i/zmeYEIhcTkOdXJb28z82gpZ7z8vzcRCfVK66nZOztpDcOpujMbCi9czudc4nMyX7zSHpLGTdzPH6ggIKHKlWGJ7kU6N/LLi5xrQypREsjFVvqOZPoPSiPUnVA2JdSt7JUenntm/EbDmceMSNpZzCQpGcJi1nSNQFvqNxE+DZej0XmfaJkq4JWbOnkKySyDJK86Sn3LJKqA4b+vbPfGqfm8mJeLS5xJSfq4P0PqvPEqFN5An0ySmWks6qzWTWv5kPQKQzymfN+oo+GdB9I2zG1jB3psoPFwNJesdnM7vqZ6KLiHVIQ4+mlH02bsT/+n3c4yXUTdpfJNWfZTLDv8G8ms9AzvHegqDx0g7x4U5otfoTX+dtLokYxz8lGvZO4iueopasemj7208QWalANNYrsnMvamZoogRXASOlQuSOrDriU+N2hjRUnHzEY83oQy1CrRjBUUwyzwpTfbkZtZVqK8+7gTiNkWJ/Mq3KeETLky4Y1ygIl3ChATM2S3nt1Uuq2dL1+2OGQHFzd0p8d5oCA+KI5HXPP9IHWlBMcQE01ZUEUq1Pn53Cp++L1VmROu1UliXnjt4PhfYW8UwHnlBRj7cPRbnzO+iDr1xTdbculbetJiw9rEvI2ltvF5mpYB7AMN9FvpKcNvbtBmzMRG3RcfeI0ntDpHJd/BiJB4J/0gErYobF07uuhz3
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(8000799017)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(336012)(107886003)(26005)(6506007)(2616005)(6512007)(36860700001)(83380400001)(47076005)(44832011)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2906002)(966005)(6486002)(478600001)(316002)(786003)(110136005)(54906003)(70206006)(70586007)(31696002)(86362001)(36756003)(356005)(81166007)(82740400003)(31686004)(40480700001)(66899024)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 13:37:57.3467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd502023-f22a-4db2-3e97-08dbe2bb6a5c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0065

Hi all,

Thank you for your responses.

As I said in my first e-mail, perf_event_max_stack is already set to 
1024 and it doesn't help unfortunately.

Also, as Namhyung has spotted, my problem isn't limited only to BPF, I 
get broken stacks for both on-CPU and off-CPU stuff. The page faults I 
caught in my debugging sessions actually come from on-CPU stack 
traversal and they cannot be currently (if at all) handled by perf 
because a sample is taken inside an interrupt handler.

In the meantime, I have managed to find the exact cause of my page 
faults, which is narrower than what I posted in my last update: it's 
NUMA automatic balancing, which unmaps program's pages to migrate them 
closer to a CPU running that program on the next page fault. Disabling 
it with "sysctl kernel.numa_balancing=0" seems to fix the broken stack 
issue and is a smaller overkill than turning off NUMA awareness 
completely in the kernel, but it's still only a workaround with a 
potential performance penalty (unless there is a manual way of setting 
up NUMA properly so that the performance penalty is negligible and 
callchains are not broken).

The ideal solution for me would be fixing perf so that stack unwinding 
can always be fully done without disabling or tinkering with any 
performance-enhancing mechanisms enabled by default. By "the proposed 
sframe unwinder", do you mean the set of patches suggested in this 
thread? 
https://lore.kernel.org/all/cover.1699487758.git.jpoimboe@kernel.org/

Best regards,
Maks Graczyk
