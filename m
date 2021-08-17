Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78DCC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 00:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59A060F39
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 00:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhHQAWe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 Aug 2021 20:22:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23322 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232929AbhHQAWc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Aug 2021 20:22:32 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H0BtW7009066;
        Tue, 17 Aug 2021 00:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Ry+NDomICGjrC/0OozeOK1n343jd+Ej7Yk3t8w+ofwE=;
 b=fHdp3k0T+VAwja4CMcrmYHZbGldDsgy/xF4tYJCJt21Ho54eYTeW5d3vvFSjhyfbLCjn
 diLWPH6cKCQNLsjms54v1ileQvyYyNmdZpvPFNJQGpK9QDiJpv0mza0lx4/pdWSH62Wk
 AxL9sHTAXFUU2kWoWicgEXUjbnmUwh/vvH5XQU2c2TPNaGgkyH2GT0ebdhwIRzOq2i6u
 ETMOVNFAsZyM6exa0Inwc/NfEX1Xh3O6h1URLzczvl/bEH5D7zmJbKya4AyGxHc4erP5
 MkGSAR4q4dDyfCG0SJKay7q9Rcb6Yc5HjGJf4mtre6aPI594J1UOT/ggADEp0DObTB0j /Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Ry+NDomICGjrC/0OozeOK1n343jd+Ej7Yk3t8w+ofwE=;
 b=XlMq2brJaW4BuCAZrNySQOoFXeTCOBbL7x3rqs1kucTOsySLTRxGxKry3cSCrPAm/Lbj
 LziaGV8p7heph/1XZbTDNj/pB3PyUymrxMZZVRErOqevNikNvPLAU+LKynq7gtE2A14Q
 UGOmZBpV5XTF6s3S6iL3S6RvWJ28nxwVtREWMTFjJ8a0iemgBIaZENXWcRklyPc2AH0q
 XrZ3fEjAgSnPOhTl3dXTaYibM8Sy0iclnSKYcE1iEQM2n0nZ1cp9GjQpsL4aRYtP8gCP
 aN/+Sz0rPZj0LRjpun0tAGvJVXFVQXXgpJYWMoMuaW2ZyKaiKfCxJreLtmlE4pzgqAxb WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd2s0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 00:21:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17H0EsZp172865;
        Tue, 17 Aug 2021 00:21:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vene2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 00:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMiqj9cUpi4NXb3ZCf1IdPgJAMbjAifXS+oDHwocPzOqgwDqlq04YdecKNTfWnn6iwoSCXKRWD18ZLKa/Ee83Q4F5uEcG9q7t2nndRBj0U2SvmFNOdc4Xs9N2rO380HgJnqdByDvL5jFlvEZSic5sEvsjqemQ94Z4mAb3fXDYF9ECeH7bxr38RnSvdr1Tz9SHpPirN9mjCBgNOj66MFJGGYTeF6WH4oRAW/zpPC7gerK0OFcFQUYfy0pc54EWJNNKXTLGw9qD0ikeSlcChbztXE0mv+1Tzmszv+3yDCUNVak8Nk+vcjvL+vJb88aY+L4qyXdShMFdgqDKCso6jAyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry+NDomICGjrC/0OozeOK1n343jd+Ej7Yk3t8w+ofwE=;
 b=fcpbbUjTRWlnaRKMvB15l0lFBdODFAO6kR0rnzyhk5Y2VIBQEr95bXZoBourZaNQZ3R7lve57vEhOuFL47uxQCW8yc4rVho47/ZbCBjOrqH/q6x/l52q9Q4ttLnJ9fLmueZXjao9i82DgdkdfjdYXeIHKuzNVDHXW+lHxu4wF15DmBSBZdx6C5yc2llBCqUM/v9RrPZL2bKWnyKR7yS7jCKHmRgN8Ek13LLcTzmPL04ewcFUqdmY0BRfIegvgQaFupPaVidcfVYxWVg5bXaNDXi7zR9nPrb60wO3cvEbyT5mnjF5zxwk2oYLO4XetGIibWJw6KJcjjaO/NQVzgaDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry+NDomICGjrC/0OozeOK1n343jd+Ej7Yk3t8w+ofwE=;
 b=pi13tbdurQpotFEInmqbBzELHsEBiDss5zClumTPSY7U2Kjg28ziyfksxW3S9kSxZAWjgvM85QV0a9fiVa1WJvlCnSK2wRsj1mjLAoY8P5RbGK6hMNxXuE2MlgEEb2/s4jNpe2qO9D9lWPtI/sk9S05nrq5IM0Y2ZGI5uexA/5E=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5226.namprd10.prod.outlook.com (2603:10b6:610:da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 00:21:44 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::7dfc:5c8a:aac:a65f]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::7dfc:5c8a:aac:a65f%4]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 00:21:44 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] perf script python: Allow reporting [un]throttle
Date:   Mon, 16 Aug 2021 17:21:33 -0700
Message-Id: <20210817002133.48097-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.4) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Tue, 17 Aug 2021 00:21:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b665c8df-09aa-4823-793a-08d96114fe41
X-MS-TrafficTypeDiagnostic: CH0PR10MB5226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5226B42E1DA1034B230D43E5DBFE9@CH0PR10MB5226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FLMoFedZSkEuU8/vS4lziv5w97iuj20U/MWitsMhYv69tTONKPRr8vhRNues?=
 =?us-ascii?Q?vdLo7+46zK7FZDARaTQB2p9Fz68OBF/Dm4jV5jYW1b7hx8b8WG18CL1QpDnq?=
 =?us-ascii?Q?fXNzfYPNh4ZFPp7nOD321lOA9faoiFjbIhQ24i3H88s+NbGjGRR/xrVUk3Wd?=
 =?us-ascii?Q?ATeeQP74EcKP9RjlTVcrgAAsYnWJ+RRq8ExV5CdkaSalJbLwDBgYKaEtqioN?=
 =?us-ascii?Q?7/n25MOoWGsyd1l6/GDZtSn5AS991amxNE22NFaoaTL/u7Nn4oWFLhZGjc2w?=
 =?us-ascii?Q?eKX2v8d9LbyZ4APagRN8C9p7btBmr26XHvHZoql50Fu9DMER37ul1lO3IbQe?=
 =?us-ascii?Q?0JVjrgA5kI8BpgPNrgXw3PocFdwxw2iMl2NEx3r/9nkZr5v1cN0QcGaB1Nby?=
 =?us-ascii?Q?AU2yhQkeEL2gOiW+tcp1JOeIbiQjGc9A6kuPrJCmmi//4cNgK3iVwz94kiu0?=
 =?us-ascii?Q?qm1G3e8ngQGCrqNBUwKRzBoJorgN6r54/bKEcT+M/ukpX/hDQoiVfLhgCjAA?=
 =?us-ascii?Q?YS1nDLJ4rrcSrDB+0rUbpy8dO4dX5OaMUmJG3H72ZRB3xx1WQmNeZuX35zj1?=
 =?us-ascii?Q?ZMj+fbgHEqXN3CKk1eeTbUqWv4eGXhqoLyEe/HR416jadxJdBP9gLztEdwxb?=
 =?us-ascii?Q?AuWFGchlTdE84f5YKaHtwU3rZRyLjTxlqenn4cQWp4lkXXTPVY2Kf/DhpRCC?=
 =?us-ascii?Q?60wBuFZ5S3QV04M1Ju6qvtqSFbhTKhjZpK/EtHVSPr5DwMG3BMgtAUkRA4uh?=
 =?us-ascii?Q?cnXrijXihf85cm4pGezbWspSE64jjHrYJ2PbQ0dHpFlIbfLbzyjmAgBLBLZQ?=
 =?us-ascii?Q?uTpK15qNMTdPq4Jz1quLxJUbSSaxhJ5SWLEBfX39zUt47vszQzJRJ/SSRxBk?=
 =?us-ascii?Q?FIUDGCmcJHem6rbjcGV20A6xpJZ5xT27BCQQWVUc/IpMtXO+PYNnx/p3FKA+?=
 =?us-ascii?Q?BQIOWCScMY0L73cR4UqsFAV+QjwkAqJSqaXUlYQLBotOXG5rpKhwedn42zUs?=
 =?us-ascii?Q?YqLO8mFOEkLAlj+DLbjSXllycoR2z1TMFogdWr6zW8ahbrDMZMDAMzRX+DA5?=
 =?us-ascii?Q?hEsDXXnhNv2bRRAm+UBjODdOR/BdZ5bth+DNelWhhesaqWnbiPqkOVOnHjMe?=
 =?us-ascii?Q?51I4oYTKzNlJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(2906002)(6486002)(52116002)(956004)(966005)(83380400001)(8676002)(38100700002)(38350700002)(5660300002)(26005)(110136005)(6666004)(478600001)(8936002)(6496006)(86362001)(103116003)(66556008)(4326008)(66476007)(66946007)(2616005)(36756003)(186003)(316002)(1076003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rao91nI6z9pj44FUtGq37wHP/lU2jEOKqFBBpLS7jsSiyXF9Anpy0x8nxG9C?=
 =?us-ascii?Q?4eJ6wasTi32fkvMEnawSkL+1zN+3Mcmlo5b+fxPNrZ6ZDVMF1KBggWwNcF4E?=
 =?us-ascii?Q?eIcT6ML89HsFegMI4+m09X2KPkoc8a+T2+BrVnWG1BW6gQZkR3MNnkHxLFtm?=
 =?us-ascii?Q?1wskIyDWQvfcWgSzajr2ATwSQhOCjISPk9rSvGttKwYdb/4ZsOIbgPI15gij?=
 =?us-ascii?Q?z8sbFNW+XSAGyIrRheXkt8CDgl5q8hqU1cqQxLevEqUEXaHTcQ7T1iHbseY7?=
 =?us-ascii?Q?drynasAJsVSKPqb0jEGwZ10ByxMfS3U0v0Za94jPkTEhBOoUYKF2saQl/cJU?=
 =?us-ascii?Q?tiLCIROM7xIGzE2hOoC2HsjxGnWXS4zulM3TsakgGyNODSOA3as3YDe+CWZ2?=
 =?us-ascii?Q?csfVraXu3CdxTxrGpK2xeZWlPtl4eEAA5zXiYK1fVhHKs6PbuO0k4AIpG/MC?=
 =?us-ascii?Q?eWa/f7JbCT5v7vZSXxa8ySvjTg4hWp86U0SyzIHcoZebYqvzlw5PkbiM1sRM?=
 =?us-ascii?Q?K23DMreL/g9kkCosPWQORQfXATc9yJsW7RA4lnc7aWF0hF5tqaRcwB10InYs?=
 =?us-ascii?Q?S8oK3e/riV5vA3KYcnH5+cBVE2A1/44NrE5MXiOIbq+daqXfCMcUEMWRmzCX?=
 =?us-ascii?Q?WTcLkWh8syluSh7/djtqDdCArT8CXbC9RjhYjlj/T9AJpQjT0wzhkTFlZUCW?=
 =?us-ascii?Q?Gy1O41ywhE6NBFbxEcKZsewIVY13W5X0iX+P11IHdQxlwLA0xivyfIgSNb4G?=
 =?us-ascii?Q?M/NPt/DMIWteo4utJQu7DM1D4oMymZsin/hGIBhDQNb8pxED1MAXXRKn6vCa?=
 =?us-ascii?Q?i4BHzK4sCr2jZIKy5k4ah7WB9Tft6k9mWma+Qtk+lqH56CcuVWs59BmvWXdh?=
 =?us-ascii?Q?E9A04To6ttBCrR9kVO27jeCBNXm7M2kgnEdPhWW3s3/iD7zubniz4oBsCZ+R?=
 =?us-ascii?Q?w0sv+gnnyZSPy94Wm40f5aLLd9JNZB3b0m2/16vJx6LR3ZlZK/BhVP5ysJvC?=
 =?us-ascii?Q?ffncDbC5KJzqJpFNnKNHsyRQVwytRzgm9k8aSQ/G4w18JUUCrWqNGfx/ud3f?=
 =?us-ascii?Q?+RRK6/njEcV4yqUzuO6+I9b9LE3JSivFzkwAyQByJIlDAIHeXbBiVD5KLSjl?=
 =?us-ascii?Q?pqLnTpMYBJ/EVCZLyeonFzKDQXxewCkNiM+72FpyrN7siyD45C5mnV3nAor9?=
 =?us-ascii?Q?yPtYIvUsJWphvRkU3k3SwckUpzZlPd2ajpHmIMiMPICVx5SDZIACZl+EbJ6c?=
 =?us-ascii?Q?XHw04hmTzYHz1JJL6nJi4bvZdaZeROHznWnWEJLjNwQrZgR8vlCFx7g+6R5s?=
 =?us-ascii?Q?F0GZzyRuCAvQiLkpaj60pOiV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b665c8df-09aa-4823-793a-08d96114fe41
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 00:21:44.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSzUUNwj26PVwDROeyi/FiNAMyR2myvyIWW0N/M7Hn3I67hFDtKAg4BQqP0WJ7yvewZMjEsRwjmHhmDM7ZbMhfkKT3dIfAeNAHunZKjrtic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5226
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170000
X-Proofpoint-ORIG-GUID: Ghjz1jqv2WNBypZUanqMdhkssVJFfyCf
X-Proofpoint-GUID: Ghjz1jqv2WNBypZUanqMdhkssVJFfyCf
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_events may sometimes throttle an event due to creating too many
samples during a given timer tick. As of now, the perf tool will not
report on throttling, which means this is a silent error. Implement a
callback for the throttle and unthrottle events within the Python
scripting engine, which can allow scripts to detect and report when
events may have been lost due to throttling.

A python script could simply define throttle() and unthrottle()
functions to begin receiving them, e.g.:

```
from __future__ import print_function

def process_event(param_dict):
    print("event cpu={} time={}".format(
        param_dict["sample"]["cpu"], param_dict["sample"]["time"]))

def throttle(*args):
    print("throttle(time={}, cpu={}, pid={}, tid={})".format(*args))

def unthrottle(*args):
    print("unthrottle(time={}, cpu={}, pid={}, tid={})".format(*args))
```

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Since this mailing list thread[1] I've been wondering about ways to
detect and handle throttling. Perf will warn when events are missed
because the ring buffer filled up, but it will not give any indication
about the throttling -- except for the throttle message logged by the
kernel. Ideally, I'd like to also extend the other perf tools to give
a warning, but detecting it after the fact via a script was easiest to
implement, and most flexible for me to use. I'd appreciate feedback on
this change as well as what such a warning in perf record/report would
look like. For example:

[ perf record: WARNING: samples were throttled %u times for %u seconds ]

[1]: https://lore.kernel.org/linux-perf-users/87lf6rclcm.fsf@stepbren-lnx.us.oracle.com/T/#u

 tools/perf/builtin-script.c                   | 13 ++++++++
 .../scripting-engines/trace-event-python.c    | 30 +++++++++++++++++++
 tools/perf/util/trace-event.h                 |  3 ++
 3 files changed, 46 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 064da7f3618d..072869a35f85 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2492,6 +2492,17 @@ process_lost_event(struct perf_tool *tool,
 			   sample->tid);
 }
 
+static int
+process_throttle_event(struct perf_tool *tool __maybe_unused,
+		       union perf_event *event,
+		       struct perf_sample *sample,
+		       struct machine *machine)
+{
+	if (scripting_ops && scripting_ops->process_throttle)
+		scripting_ops->process_throttle(event, sample, machine);
+	return 0;
+}
+
 static int
 process_finished_round_event(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
@@ -3652,6 +3663,8 @@ int cmd_script(int argc, const char **argv)
 			.stat_config	 = process_stat_config_event,
 			.thread_map	 = process_thread_map_event,
 			.cpu_map	 = process_cpu_map_event,
+			.throttle	 = process_throttle_event,
+			.unthrottle	 = process_throttle_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
 		},
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 69129e2aa7a1..5ef1ba5e29bb 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1422,6 +1422,35 @@ static void python_process_event(union perf_event *event,
 	}
 }
 
+static void python_process_throttle(union perf_event *event,
+				    struct perf_sample *sample,
+				    struct machine *machine)
+{
+	const char *handler_name;
+	PyObject *handler, *t;
+
+	if (event->header.type == PERF_RECORD_THROTTLE)
+		handler_name = "throttle";
+	else
+		handler_name = "unthrottle";
+	handler = get_handler(handler_name);
+	if (!handler)
+		return;
+
+	t = tuple_new(4);
+	if (!t)
+		return;
+
+	tuple_set_u64(t, 0, sample->time);
+	tuple_set_s32(t, 1, sample->cpu);
+	tuple_set_s32(t, 2, sample->pid);
+	tuple_set_s32(t, 3, sample->tid);
+
+	call_object(handler, t, handler_name);
+
+	Py_DECREF(t);
+}
+
 static void python_do_process_switch(union perf_event *event,
 				     struct perf_sample *sample,
 				     struct machine *machine)
@@ -2079,5 +2108,6 @@ struct scripting_ops python_scripting_ops = {
 	.process_auxtrace_error	= python_process_auxtrace_error,
 	.process_stat		= python_process_stat,
 	.process_stat_interval	= python_process_stat_interval,
+	.process_throttle	= python_process_throttle,
 	.generate_script	= python_generate_script,
 };
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 54aadeedf28c..640981105788 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -90,6 +90,9 @@ struct scripting_ops {
 	void (*process_stat)(struct perf_stat_config *config,
 			     struct evsel *evsel, u64 tstamp);
 	void (*process_stat_interval)(u64 tstamp);
+	void (*process_throttle)(union perf_event *event,
+				 struct perf_sample *sample,
+				 struct machine *machine);
 	int (*generate_script) (struct tep_handle *pevent, const char *outfile);
 };
 
-- 
2.30.2

