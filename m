Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975FF63BB
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="GKtexEjG";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="GKtexEjG"
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2070.outbound.protection.outlook.com [40.107.24.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C672A262
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 02:45:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goedHT5JgtvH7binr5qtdw3GEeC7oMZ4NHSbIe1k9yI8mIwur7WfwbZriRGcQvhRms3tn/J9eqfn6qm8KqYAjk+6Shr1fPtRqp+3yLdkfvIUUzgNG8Hj6SkL5s5zoktxz47pWq42zwAS7JLPZhwIGOtCxMqCbjl8x+lO/TKm50AYqL05r8QxnxUbea/3GvKHxSLWB2cLfOCTE7HAxwyZhr4Q3f0aLXMd4/2bFY/1IgXjnuUvg4+mrSgjcHPOVuYAJ9NCaFh1sw0LzNsLlVDA5EuNM4sfhYFDWBwxXm+nANBBVXJz9CTf1IbUofkwIFNEriN+6Q1wRxTlyuKDoG82Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwrYDr8A4UMAZVXLaCmCL0yJ1hu1W05waF3jJgOlM+o=;
 b=A+vmnRhGP0i6UrHt9yyNS0Q0MtoVuXq6/91z6ooGK52HKkJzvmsR23SF7YbNYF+3wZKWG2xwZZsaIOurx7zUarHvsxsloAkyO8H16vcw5zAnTua3IxWNkjKK0vTYOnsmbsc3C9vDBPcS9+9NIrKgSjd7ic+RkKf/lwyqJcSTQr4ByLTuvrshSDqGrKvSeIVk81v8YIfrgDxrVv/iYtI4hZAJZrWts465p+oR9I6deyExg3esFb7ZUYpuzws0O+TbwKl6ESRGD1DN32oMLKSJNZ9atV22UpitGiBmCLDDpOZDPeCms8OUA6bzLnVE12r2xB2ivsbl5J0HGu2/BYuerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwrYDr8A4UMAZVXLaCmCL0yJ1hu1W05waF3jJgOlM+o=;
 b=GKtexEjGYof2XlXd1BPDC4jBQN2nlj0pKUk8EGG9p3yDqYKbIDMiaJlolFVIZIEtMVRjtZTyYJnaWU/uFZxwGX15LgEdpPOiVrYtUbIhFIXdPyB8r0IACd2apvWxzvKew5jSkicjmcXjNl1j10cbW4f7na8ysWatMXjhi1hDBdM=
Received: from DUZPR01CA0242.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::14) by GV0P278MB1127.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:4f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 10:45:36 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::18) by DUZPR01CA0242.outlook.office365.com
 (2603:10a6:10:4b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 10:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 10:45:35 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.4])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTP id 96668FE0C5
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 11:45:35 +0100 (CET)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 49C32FE0B9
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 11:45:34 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=GKtexEjG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwrYDr8A4UMAZVXLaCmCL0yJ1hu1W05waF3jJgOlM+o=;
 b=GKtexEjGYof2XlXd1BPDC4jBQN2nlj0pKUk8EGG9p3yDqYKbIDMiaJlolFVIZIEtMVRjtZTyYJnaWU/uFZxwGX15LgEdpPOiVrYtUbIhFIXdPyB8r0IACd2apvWxzvKew5jSkicjmcXjNl1j10cbW4f7na8ysWatMXjhi1hDBdM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::11)
 by GV0P278MB1173.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 10:45:33 +0000
Received: from ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d9d4:3fda:5220:b62e]) by ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d9d4:3fda:5220:b62e%7]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 10:45:33 +0000
Message-ID: <b219266a-47cd-43ca-9f8d-c7743949ae14@cern.ch>
Date: Fri, 10 Nov 2023 11:45:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Broken stack traces with --call-graph=fp and a multi-threaded app
 due to page faults?
From: Maksymilian Graczyk <maksymilian.graczyk@cern.ch>
To: linux-perf-users@vger.kernel.org
Cc: syclops-project <syclops-project@cern.ch>,
 Guilherme Amadio <guilherme.amadio@cern.ch>,
 Stephan Hageboeck <stephan.hageboeck@cern.ch>
References: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch>
Content-Language: en-US
In-Reply-To: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:56::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1123:EE_|GV0P278MB1173:EE_|DB5PEPF00014B8E:EE_|GV0P278MB1127:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6f2a82-8077-4063-78db-08dbe1da2c02
X-LD-Processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 wR0eAiWKgXfBvykaGk5OZOSy8Tv6R0GUZTQQ6kOlHylOm39LtcPmtJ6E89uEcK6gsDuq+rSCiealw0dbIWYIt5MtYT+pT2+FZ2qhiVl6eWq18v8p81o7yyaDX9ZkSwFIT05vNpLgPmpcGG+l61YE+R/WxM15ESr/5ofjYO+a29+Saj1BGPBb1lXwiVZS23Y8gy+cwRY5Lf93bsDu2JkprxMGM2vY1EXovYZOjfufLcYLAWB6s+ST2ZdIrYn1UnpGFPToPfQRwmHKmsGRVQUlOgpaO83hnCe6GawMWKWmAK2s1hDkeStVOO9RPW67qcKlrDFmGT1qHnPiy4aXmWm1aN5i6YhGNBjCqtyiKH7idd1kNTCGrJKyGcrjl8l8VTcuXpJPw2T24eOzL85wRtyWV7Qt19JPbMLCy4hv2QPqPYcCyKw8gCsRvXzqVJKl5aDiNsRMBoccmKKSrZLHZZEFI8018QbkEqGxSVDd6ePTCvuN1doyCZOdb5asWTDjeMpse244GMlb0LLlt8caYxQbqzyIU4+MP8eC6xNcEUqO4Q6kGcRv+4wLXaTd+D0ANb82pveAvBi0E7skRl9YKO8ASnvsJm3OFonhEjU9wuI5IkJtciHRlusLKkEs585zwBf1CbzP6I/dAz+X9elwLzwzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1173
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ebe917b1-f545-4a7c-5312-08dbe1da2a13
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KerKjMSOwFFEkQPAgriQZkomP3V171UOTOveit5VCBiSKGe8t1QaCNShAI1CuGftNyQmaOA90fm0rkF3WI+yPIjkdBdSZ/oom4aXuZzWQmyEgLn+KrQL85cjjPP9XD3D5tupOQwcaJI+jtlcSAgt5x3KXui+ZAPItBNZ7TEMb5Ga7oRcRWrVxL+HTp/+uKdAxLtoC8zkiyuzbcyxL1CHMoArY6XtKz/67ftfeekiJqNx4zsUk58OAvBhRZ/Hc2ElVpAGVCsKkqJGhg+k1AO6OjAYRRmfsgBLHwrVckqgLR6phjaEq5DqbLGODRysCkaSJ6/qTxq73jf+7lU3QxOvuHtUrWIXRh3cxXaIF7v11moavaNpDzrChUm+2XrRrl0l5bkBwHpisvj4ppWeBl9h9tmDYNj8I8kdUlfEmooto/Hp1jn4vdEqQKskNVL+I4J8Fq6EhN46JPggPp4UQlp87ecmEdvk36tjHB7WDj5gH976TCh5cLbz1l6ckbZj2MLONUD2lvM466fwiz8OB3oRREhsUA/SJeZtiesfGhB1m4M06lu+yRf6dgJVY0ZOuYCAfMv3RUf/nYyuY9TdLCATg7PHWwq5waNYOQMjp8NuqnwRSSgEhlooRBprpbTi+W61ps8l2aSh6vsGa66tw5cRTcBGkh7ipGOdxTbn8uByf3MnR9U/z2YibRQBSkRaU4YwpGPcy/9LeLllhrD81KRMZPZytGWT6r4dAb3yuLWcOb4VvyUam2dg6sQ5hqjqRa/wsDn5YgR3UhnqZNwtFcJSw8RWakVMAsskJHQdZmiyrus=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(31686004)(40460700003)(40480700001)(41300700001)(26005)(6512007)(6506007)(2616005)(336012)(81166007)(47076005)(107886003)(36756003)(356005)(82740400003)(53546011)(6486002)(86362001)(31696002)(5660300002)(966005)(44832011)(83380400001)(2906002)(8936002)(8676002)(6916009)(4326008)(316002)(36860700001)(54906003)(70586007)(478600001)(70206006)(786003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 10:45:35.9599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6f2a82-8077-4063-78db-08dbe1da2c02
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1127

Hello again,

I would like to add an update:

My machine turns out to have NUMA due to having two separate CPUs.

Broken stacks virtually disappear when I disable NUMA awareness in the 
kernel by adding "numa=off" to its boot options.

Therefore, I am quite certain that the problem is caused by something 
related to the NUMA memory management in Linux.

The questions now are:
1. How does turning off NUMA awareness affect performance?
2. Can the problem be fixed without resorting to turning off NUMA 
awareness? (Making kernel configuration changes? Patching the kernel? 
Changing something in perf itself? ...)

Best regards,
Maks Graczyk

On 08/11/2023 11:46, Maksymilian Graczyk wrote:
> Hello all,
>
> I have a problem with broken stack traces in perf when I profile a 
> small multi-threaded program in C producing deep (~1000 entries) 
> stacks with "perf record --call-graph=fp -e task-clock -F <any number> 
> --off-cpu" attached to the program's PID. The callchains seem to stop 
> at "random" points throughout my application, occasionally managing to 
> reach the bottom (i.e. either "start" or "clone3").
>
> This is the machine configuration I use:
>
> * Intel Xeon Silver 4216 @ 2.10 GHz, with two 16-core CPUs and 
> hyper-threading disabled
> * 180 GB RAM, with no errors detected by Memtest86+ and no swap
> * Gentoo with Linux 6.5.8 (installed from the Gentoo repo with 
> gentoo-sources and compiled using this config: 
> https://gist.github.com/maksgraczyk/1bce96841a5b2cb2a92f725635c04bf2)
> * perf 6.6 with this quick patch of mine: 
> https://gist.github.com/maksgraczyk/ee1dd98dda79129a35f7fd3acffb35fd
> * Everything is compiled with "-fno-omit-frame-pointer" and 
> "-mno-omit-leaf-frame-pointer" gcc flags
> * kernel.perf_event_max_stack is set to 1024 and 
> kernel.perf_event_paranoid is set to -1
>
> The code of the profiled program is at 
> https://gist.github.com/maksgraczyk/da2bc6d0be9d4e7d88f8bea45221a542 
> (the higher the value of NUM_THREADS, the more likely the issue is to 
> occur; you may need to compile the code without compiler optimisations).
>
> Alongside sampling-based profiling, I run syscall profiling with a 
> separate "perf record" instance attached to the same PID.
>
> When I debug the kernel using kgdb, I see more-or-less the following 
> behaviour happening in the stack traversal loop in 
> perf_callchain_user() in arch/x86/events/core.c for the same thread 
> being profiled:
>
> 1. The first sample goes fine, the entire stack is traversed.
> 2. The second sample breaks at some point inside my program, with a 
> page fault due to page not present.
> 3. The third sample breaks at another *earlier* point inside my 
> program, with a page fault due to page not present.
> 4. The fourth sample breaks at another *later* point inside my 
> program, with a page fault due to page not present.
>
> The stack frame addresses do not change throughout profiling and all 
> page faults happen at __get_user(frame.next_frame, &fp->next_frame). 
> The behaviour above also occurs occasionally in a single-threaded 
> variant of the code (without pthread at all) with a very high sampling 
> frequency (tens of thousands Hz).
>
> This issue makes profiling results unreliable for my use case, as I 
> usually profile multi-threaded applications with deep stacks with 
> hundreds of entries (hence why my test program also produces a deep 
> stack) and use flame graphs for later analysis.
>
> Could you help me diagnose the problem? For example, what may be the 
> cause of my page faults? I also did tests (without debugging though) 
> without syscall profiling and the "--off-cpu" flag, broken stacks 
> still appeared.
>
> (I cannot use DWARF because it makes profiling too slow and perf.data 
> size too large in my tests. I also want to avoid using 
> non-portable/vendor-specific stack unwinding solutions like LBR, as we 
> may need to run profiling on non-Intel CPUs.)
>
> Best regards,
> Maks Graczyk

