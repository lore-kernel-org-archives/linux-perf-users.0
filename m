Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F641FC17
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="w58+rQzh";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="w58+rQzh"
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2045.outbound.protection.outlook.com [40.107.24.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2938A2685
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 02:46:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAXoOzHW7tXuau1TklHk33lIZKLGmLvl77cwkYDjcG20IG9yBK6ihIijdOn2dcyvzvpxnQa7PIHiQKNQ6lGvryMxELWeCUsz3dWtdBLq0IBRzc3DFKCW/TiK2KVyruRw5cu1e/tu0cR6O5GdrKRN3RUVEnWGIiIbNqKEkrveOxASK5AWQQ4i99M7GvuDOPv29DEz+Ez6VOswOjucxDhl80tpuwlNCtZEOpJiBLtM3//iVSvUs0J66jiaRR5xreHQr+Mvcr/EQzNTxlBrzztNLEH+xKwxtPVuzlWmGOr08t4MdWecK0q5bp/fqFKFlGe5QCEE0RuZLjfsYq6inGTtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP9JPg6spVdw44pIahxCNhzoMR5t6VeCMRKHiFuYJOQ=;
 b=X/OQkd34dXmwXRQHX1jd2uqGiLwudtHPWAf0pgFSnIUeC5JdHsB43kVbvW3t9gcFp6zUBg6TJciBSNNifk4EETVX8kcEMjyV51PTEO7AHmqIL7XTvy0X8DRXKmxnaB2s8EXG/cCM7MgMhWy9LgUHShlHHY9L/FTISnT0VH2jr0A7J5wLD5dknmxneuLiTxXjAWRaxD4R3s9rTJmz6FUdjLlXlXybPCbaUlf81XI2Hz7eT9SHrwKZR3v51fR/sKeYn1esnAFkqLG1qpEbOtDyq5HrJJQS8dXnvrEG3zbfO5u1a3cFGMKQyaCCYhKpTotGBS1Vv2azNoggaPFU9E0SqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP9JPg6spVdw44pIahxCNhzoMR5t6VeCMRKHiFuYJOQ=;
 b=w58+rQzhg5elOVL1dZEEt7ERLQzNu08A8sLsUyTA4nzXg3VdLrSXA/HX749UWASjFyE1sIkz83KxmZeUdNeEtvtpv7435sO25Nrixe55Ha/05X7sb7tMU9ho62wNOvs2a4E8EFnHIzp8DEnSf/EDyn0PjG6SIrmopu0+j7WazI8=
Received: from DB7PR05CA0035.eurprd05.prod.outlook.com (2603:10a6:10:36::48)
 by GV0P278MB0145.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 10:46:08 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::8b) by DB7PR05CA0035.outlook.office365.com
 (2603:10a6:10:36::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 10:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 10:46:08 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.4])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTP id C958A82E0D
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 11:46:07 +0100 (CET)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id DB0E082DE9
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 11:46:06 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=w58+rQzh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP9JPg6spVdw44pIahxCNhzoMR5t6VeCMRKHiFuYJOQ=;
 b=w58+rQzhg5elOVL1dZEEt7ERLQzNu08A8sLsUyTA4nzXg3VdLrSXA/HX749UWASjFyE1sIkz83KxmZeUdNeEtvtpv7435sO25Nrixe55Ha/05X7sb7tMU9ho62wNOvs2a4E8EFnHIzp8DEnSf/EDyn0PjG6SIrmopu0+j7WazI8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::11)
 by ZR0P278MB0073.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:18::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 10:46:05 +0000
Received: from ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 ([fe80::dc5f:fad6:2a1d:2820]) by ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 ([fe80::dc5f:fad6:2a1d:2820%2]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 10:46:05 +0000
Message-ID: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch>
Date: Wed, 8 Nov 2023 11:46:03 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Maksymilian Graczyk <maksymilian.graczyk@cern.ch>
To: linux-perf-users@vger.kernel.org
Cc: syclops-project <syclops-project@cern.ch>,
 Guilherme Amadio <guilherme.amadio@cern.ch>,
 Stephan Hageboeck <stephan.hageboeck@cern.ch>
Subject: Broken stack traces with --call-graph=fp and a multi-threaded app due
 to page faults?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:56::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1123:EE_|ZR0P278MB0073:EE_|DB5PEPF00014B88:EE_|GV0P278MB0145:EE_
X-MS-Office365-Filtering-Correlation-Id: ce95771c-1be9-477b-1943-08dbe047ea68
X-LD-Processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 d/DoXk9zH7brl4krJTKdDM9cDBa3fMW1csrprQTzeep6tNuoI6MnCgK8Vps9DVXKR31LG040vi403j0KOjRamgvxoxPr+AKnNrtFoyroCE6apeSqYgspCQO31/mRHM2hcpWFTbG1UPlAN65AhB8bgjRLxDwanczWbYySE8lnjJDSCk3gg5oe5xKc1esxckgKL4ZIZNyRi5QGEZhPa9oOQ6agTrxBLRJP2linPHeyNaBKddTga6/ouKFuXP95yz7gbDx8pXgiIOqxT0f6HT4OqI7lJvyOe6iYBOIUa10clfFv6Gt7f/dQC+AZlL1TTz1w8li/ZM7En8k/yYozfSb4yAKLB+50cIuDtgHICUOwTvuEiigcVz+FD9/oCx7uN2rp5mneVPtoOW/qmvLvfw15B5dop/1BGzC7vkyWW8LsjHBarnHDyseXk94x3vlMZX+YDKCudHeBgKlVfqaxq7O4Xq/xUb4scyAD955gsNp/GjTPeZTYut3RcwSpe3KieIZHpR39MqjGIgRi7ceOKaOBKgbEwNsjJtEcw4upjEHNhnFwOcYPE490XR/4ienv1e7EmvRqBeJRq02yUE0TE2ktnxuSJxcpGPgft5Q4e4Mbx758VEKwgJ6U8JOfFBRHi3aH4IErBIbd7bBJyJPDk37bFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0073
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f3f88cdf-e328-45b8-50f8-08dbe047e8a3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PdqtgDw/D8xw6TE28+4DnwpkvAHfvG55I7ozwN4W1NL2DFt0CdhP8NtiAU5ggOKsTVNX+am0G586l7LstcxShygr87FQ70jaSUqE5Hhc5HRWe4dSi0nMH/YQ+23/QgKIHUsJ3Fj1npPivnKTjuTQ0uddIpa8UxEgkxpuOSVX2nj5O7OUNGO1PyNgcRXOI1ZynNDmPLQP0a+fKiPMQAw8zNU05FGrwx97Y18dO9QtleIxhRl3xVBNV6vXXtG5kHBkKZsPwZC51Hpb2jeu2bJbZzw7ToA+pi9d1T76GhHREzDlVcsgdVRR1xTZEIQQukXx8UvGjZ5w/qHi0yAxwfUjn5LOpiv9YEh6LdWja98VwodBGCWnottXsCbYe7tFRbhW565k/bdKIol2oRew7fcb4O/gJ6WYRE3pEJwtnnI3TmpZ1Gr02TUB19SblzkDt3a6QMC1tI0OaA+ZFh7q4rHTjRUUvKuNrwz/UfUeAt22hwR5hHuSMyzhGrl3sc6FMTC7KcBTmshfq4FXD7Sbup6/5570SweF9k94iEXRcrCd8g8X5sdITcBLwoxqqAblOLKacvki3krj5J1L9jQumjIL/OTDBiq18UvpPwct3ykgTsiz8P7UyYFp2MDoUJoZZPRBJsTfettVXk2+23Pm83RPFu602/u4ji0LL4cggtWwYnF6G7qj0dZbecXIKRk//A8519iNpXipyeRfFjP3Dd2gpyFQ3gF0ZWhLb2dVSZxSMlZrnXtBTpXiF1J27HaxbDfocVzATDwlNxnfgYrQkzfyUCUMb3pIZhq4FHD/3qCCfPA=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(336012)(40460700003)(40480700001)(31686004)(6486002)(966005)(478600001)(36860700001)(47076005)(31696002)(86362001)(81166007)(83380400001)(356005)(107886003)(2616005)(6506007)(4326008)(6512007)(6916009)(786003)(316002)(70586007)(70206006)(44832011)(82740400003)(26005)(54906003)(2906002)(36756003)(41300700001)(5660300002)(8936002)(8676002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:46:08.1797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce95771c-1be9-477b-1943-08dbe047ea68
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0145

Hello all,

I have a problem with broken stack traces in perf when I profile a small 
multi-threaded program in C producing deep (~1000 entries) stacks with 
"perf record --call-graph=fp -e task-clock -F <any number> --off-cpu" 
attached to the program's PID. The callchains seem to stop at "random" 
points throughout my application, occasionally managing to reach the 
bottom (i.e. either "start" or "clone3").

This is the machine configuration I use:

* Intel Xeon Silver 4216 @ 2.10 GHz, with two 16-core CPUs and 
hyper-threading disabled
* 180 GB RAM, with no errors detected by Memtest86+ and no swap
* Gentoo with Linux 6.5.8 (installed from the Gentoo repo with 
gentoo-sources and compiled using this config: 
https://gist.github.com/maksgraczyk/1bce96841a5b2cb2a92f725635c04bf2)
* perf 6.6 with this quick patch of mine: 
https://gist.github.com/maksgraczyk/ee1dd98dda79129a35f7fd3acffb35fd
* Everything is compiled with "-fno-omit-frame-pointer" and 
"-mno-omit-leaf-frame-pointer" gcc flags
* kernel.perf_event_max_stack is set to 1024 and 
kernel.perf_event_paranoid is set to -1

The code of the profiled program is at 
https://gist.github.com/maksgraczyk/da2bc6d0be9d4e7d88f8bea45221a542 
(the higher the value of NUM_THREADS, the more likely the issue is to 
occur; you may need to compile the code without compiler optimisations).

Alongside sampling-based profiling, I run syscall profiling with a 
separate "perf record" instance attached to the same PID.

When I debug the kernel using kgdb, I see more-or-less the following 
behaviour happening in the stack traversal loop in perf_callchain_user() 
in arch/x86/events/core.c for the same thread being profiled:

1. The first sample goes fine, the entire stack is traversed.
2. The second sample breaks at some point inside my program, with a page 
fault due to page not present.
3. The third sample breaks at another *earlier* point inside my program, 
with a page fault due to page not present.
4. The fourth sample breaks at another *later* point inside my program, 
with a page fault due to page not present.

The stack frame addresses do not change throughout profiling and all 
page faults happen at __get_user(frame.next_frame, &fp->next_frame). The 
behaviour above also occurs occasionally in a single-threaded variant of 
the code (without pthread at all) with a very high sampling frequency 
(tens of thousands Hz).

This issue makes profiling results unreliable for my use case, as I 
usually profile multi-threaded applications with deep stacks with 
hundreds of entries (hence why my test program also produces a deep 
stack) and use flame graphs for later analysis.

Could you help me diagnose the problem? For example, what may be the 
cause of my page faults? I also did tests (without debugging though) 
without syscall profiling and the "--off-cpu" flag, broken stacks still 
appeared.

(I cannot use DWARF because it makes profiling too slow and perf.data 
size too large in my tests. I also want to avoid using 
non-portable/vendor-specific stack unwinding solutions like LBR, as we 
may need to run profiling on non-Intel CPUs.)

Best regards,
Maks Graczyk
