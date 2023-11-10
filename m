Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA8612B75
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="rqxf0aqc";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="rqxf0aqc"
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2076.outbound.protection.outlook.com [40.107.23.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814ED26318
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 02:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqy7b7hX7PqeY4OIIxVwWPScpl65G4f6WQhob3KpuoOhtd4a60FPkCh3/tu6ZznktoVWDe3EnVpFGJTMBGFp1lw7FuISkpBD6GPieutqBCHzms5kO43Ri0Jmuoot/WO8xNzQnwOyNoelf0a7DNc3AOgIfuLJ3udF/1WfRmBF0sA1ebXrpATmSrf9jrnxxhbbmfIbT7pdjgAS4tk/EmwVQHPiDoWaBkdqiWOCC4mdYSRCW5v631Cf4T8irCv5hCA4acD93+skwBqmdV81Z9mtC3YEKGiKouRMB+HtXJwYZ3QW3SyhhX6M8APdb/jGOzGVGJMfgm4Qiu8KzJzDgNgVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EadjWWJeFDFijq/2ptN3fqCNoEbFGP0ddeTd5DN+FSA=;
 b=GBceqAhvEAvc6i/79nTDPP3WEb6bVqvLwPXl7CAAdS/8SkMiMvBe0U3KmHlE7TA6JeAV7U/kAkzpIsOuCqqRoz3I6ITcSObHRP0tvHP0WNIbkA729oxCyBoOpvrCdsUGm4k+fgrUVdOQeU/tmV4Cwo5QRN6Ir1YfCtUZqqOkN2PQb5sCdXQH+0XjIsSImvl6AsCEXgEIF3ZLi2/Wc3WHBW5OdzjM93awUOgi/8syhtjXeULJ8YgIuMw2+uCEAaa2j73xJudPHYj3PTkpZcVwv44obLD+zl5+u5xA7mDTW0W/urUKd0uDJPHVqkPNVDZIguSVXNwe02Cw2YNFzJDoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.2.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EadjWWJeFDFijq/2ptN3fqCNoEbFGP0ddeTd5DN+FSA=;
 b=rqxf0aqcbV+y7Mvr1WEUC6nin1dEAvL3r3OMA7zuOsddlTmbDYc0lqPWcmCf18qBJ+wmhSF7J8zYCUEVpku5Tu7jzMpV91CwiGOL82n1iSgrhOISSAehyN+VADxs0W7TP9TVo6XQCIEtw7MJdCb7gLwrZ5un9xwYQp2GTORi8hc=
Received: from DU2PR04CA0338.eurprd04.prod.outlook.com (2603:10a6:10:2b4::8)
 by GVAP278MB0780.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 10:51:49 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::c1) by DU2PR04CA0338.outlook.office365.com
 (2603:10a6:10:2b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 10:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.2.244)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.2.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.2.244; helo=mx2.crn.activeguard.cloud; pr=C
Received: from mx2.crn.activeguard.cloud (51.107.2.244) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18 via Frontend Transport; Fri, 10 Nov 2023 10:51:49 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTP id E743F7FCB5
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 11:51:48 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTPS id 113827FC67
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 11:51:48 +0100 (CET)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=rqxf0aqc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EadjWWJeFDFijq/2ptN3fqCNoEbFGP0ddeTd5DN+FSA=;
 b=rqxf0aqcbV+y7Mvr1WEUC6nin1dEAvL3r3OMA7zuOsddlTmbDYc0lqPWcmCf18qBJ+wmhSF7J8zYCUEVpku5Tu7jzMpV91CwiGOL82n1iSgrhOISSAehyN+VADxs0W7TP9TVo6XQCIEtw7MJdCb7gLwrZ5un9xwYQp2GTORi8hc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::11)
 by GV0P278MB1128.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 10:51:46 +0000
Received: from ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d9d4:3fda:5220:b62e]) by ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d9d4:3fda:5220:b62e%7]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 10:51:46 +0000
Message-ID: <974e4301-5994-4136-bbbc-58ff5dfbb6ab@cern.ch>
Date: Fri, 10 Nov 2023 11:51:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Broken stack traces with --call-graph=fp and a multi-threaded app
 due to page faults?
Content-Language: en-US
From: Maksymilian Graczyk <maksymilian.graczyk@cern.ch>
To: linux-perf-users@vger.kernel.org
Cc: syclops-project <syclops-project@cern.ch>,
 Guilherme Amadio <guilherme.amadio@cern.ch>,
 Stephan Hageboeck <stephan.hageboeck@cern.ch>
References: <de597d7c-848e-4a35-887a-4cdefa23ecd2@cern.ch>
 <b219266a-47cd-43ca-9f8d-c7743949ae14@cern.ch>
In-Reply-To: <b219266a-47cd-43ca-9f8d-c7743949ae14@cern.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To ZR0P278MB1123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:56::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1123:EE_|GV0P278MB1128:EE_|DU6PEPF00009524:EE_|GVAP278MB0780:EE_
X-MS-Office365-Filtering-Correlation-Id: fd44d4ae-e9e7-4c59-23b3-08dbe1db0a8e
X-LD-Processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 FKmPzDKQ1JhtJGJ7KWxd0y7U08D8VmJufHW06EG9E5bswK9dc/UkUyEpG7m4hOUxheep3zA4/4hN4DpjWJt/vJuYZn7ya3jL6xiAmtszs+nmyGD3B4OROqPmH6PFjE/Y+cgioG205isUJIMgMHOS7NuZmsUDE6470oiV61QDOprg6ozNAANhFJYo+fIOMidPpY0qtMV/6RBXqAq+r/boBtCFm6jhyYprtvXEGpEMUZxYurVdTMfmRgIhj1YGQdQlrtvHGVLNyV+mPz9MTN0SNdEeo4aLl2+4M8Hz6TnMDsxL5FkLhmdijFxMIY33hW5DU2WXUph9+52Wa61lOik3zckkvX7uuJKi5Q1Iw8YLrrVe88rx0suBBDSBEVyQ5paXsgKwIc9XmdcCS3qGTAUe37d5d0uVbUERBITjcCU9UVbl0OH8ihN0Z9JI7MaZxMvR3AvAWoPoj0GX07A082bOkKP+12tIany0UzWzLIhSzkaN+3A1Rn+Gu8SVNtCi+sNlcpfLGEDV6fM8qIb/yOBctZ8BcYSx8l2/stEpKIUlZCcHekrXEWXQiJfdMl1+tDmgbUawbs/CLKqMjjL4kGGHYOrXn+o4V0XbuwjoYBfCraf6kMB79lHU4TZvOIMkwWDUCsYHCJ4vW8OVI4aSeUlK7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1128
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c16eeff0-2c55-49d8-691c-08dbe1db08c2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yGiQs5U3DDSzPacqVnbDIb87swPPQXM4vAK3M99703IGORIr7UptsAwHyA58NGUTzniBP+vC9bsIY0NgIyPFZr3hXwQuscphpSKwzgNDL1jrrAurkdYvzg3YTOFS8xhz//ACi5YMnLlZ+eVuJKOAGKJ1ETLthHEY+XuwPQf/m356UrfKtF1x0ioPmJYOdwRXrbTwQuMgrRoPA7769THCfjig4MpsPtqjcR5qIIUCq9Cd1BXSRy5QJvjeYlOKUg63UvV0m6Fwb5tnDgCHswsA7+qqEgKd7h+Abkpay48oPNijKYjXya6h8YiHXbtHcS0c6kaUk0fqThI1uNDULc4AW60qD9hmaTIWcJRblZpjzfjaqyxwVGy5CRFeZikGKg8ig21OQwx5c1D2wWjP1Mby1zJcrFxsfxlo8RbmPgaOq9c26PAKTcSXRD2ZOiCIsI/xVnYhDvnCnLBl37ImkWnX4d1EmAngE7WsHErhBOJFO1GBtKe1ah+2vDux8Dq8Nl6fEVd+tPbHxe+Zyu2HFvAmrH7sc+zFE+Z5Jk2ivi/glPsRGy4OFYijX0KiI+WG8V8pHIzHx+Kz5g54YWVMciONMY3LlrMHRTM9MQcT+ppGzkdHTFmWP6P9YYgvnEx9BFUGeOuZZekZhSH/knzFBv/VtU0qHSbj8tQzKsQBlDJxOGJkLrfxdkxWE2gGSOmMvqow3537AqZ2MxrGdpv2lxBoE/zbRQmOVNRoF2ApvmSTit8lp+gIhQRZ8TKXap8+jDm3DdvyaBhFU0nwFZ0x8MG0Usz0qX9BZqBuYvKOosg0EOBOmzIaMCFkZxCb6m59BJz5
X-Forefront-Antispam-Report:
	CIP:51.107.2.244;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx2.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(356005)(6512007)(36860700001)(40480700001)(53546011)(83380400001)(81166007)(6506007)(47076005)(31686004)(82740400003)(40460700003)(336012)(41300700001)(2616005)(4744005)(86362001)(2906002)(44832011)(8936002)(5660300002)(8676002)(31696002)(36756003)(70586007)(54906003)(4326008)(6916009)(316002)(70206006)(786003)(26005)(107886003)(478600001)(6486002)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 10:51:49.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd44d4ae-e9e7-4c59-23b3-08dbe1db0a8e
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.2.244];Helo=[mx2.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0780

On 10/11/2023 11:45, Maksymilian Graczyk wrote:
> Hello again,
>
> I would like to add an update:
>
> My machine turns out to have NUMA due to having two separate CPUs.
>
> Broken stacks virtually disappear when I disable NUMA awareness in the 
> kernel by adding "numa=off" to its boot options.
>
> Therefore, I am quite certain that the problem is caused by something 
> related to the NUMA memory management in Linux.
>
> The questions now are:
> 1. How does turning off NUMA awareness affect performance?
> 2. Can the problem be fixed without resorting to turning off NUMA 
> awareness? (Making kernel configuration changes? Patching the kernel? 
> Changing something in perf itself? ...)
>
> Best regards,
> Maks Graczyk

Apologies, my e-mail program quotes an original message at the end 
rather than at the beginning by default and being used to standard 
e-mail conversations, I have forgotten to make changes to my previous 
message to adhere to the netiquette. Sorry again!
