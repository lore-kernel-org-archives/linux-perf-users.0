Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F6C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 20:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0158E610A2
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 20:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhIAUtT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:49:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:17562 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhIAUtS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 16:49:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181I4EB5025879;
        Wed, 1 Sep 2021 20:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=/TnkE0UfAF92yOSUC0CHFyEO8CnkKN/rsHEKCtdVkXk=;
 b=bNrNSYUJthoIp8fpWQGz1zu9RliitDh9cjgctTyNMWoS2GdmvGDozp1kehQTPujTrrNj
 ApKqpKvzdIAmo5/nGRxHYAHXAWEay7alZRlsUO+kVZXecJ0FdQD43lYWbQmFDPX6BuO7
 RjU+VxPBNnpSOK7TVHud8M2FAMHSZfbX9c/6JGSN6eOXvk3LWh1+ugbxoDyEuaCmjxdY
 UlXQpi5LIm6Z3gSzCBEGK6zxyxGO/SaGFzvDFPl16VcidhrEx6K9SgnsCvEIyBuQeqzF
 lmxlEak6Q+7nSq6ig5IOTu+0U1YAu0AHWhQUVHgtmf6yEzX3wBHYdRyU5xjhs0RNs+MW jA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=/TnkE0UfAF92yOSUC0CHFyEO8CnkKN/rsHEKCtdVkXk=;
 b=MoyDRW5rT44e69WffYUlygRwK5hJnayheHcmb37U9RXmvYo0S86BrwVbVvfYERjgMe8b
 o5lTe4TXgB9mMn6NH0qR+Zaik39aAj1MPRLejuUq6N+Nwvn1dF3dvjqp0e82kac5SOkW
 0MKhp+Vm2TKVfAzNE/cpjZms1IvC6Q4FCnHibv6w/Yt6gN6AA03NB7ug+INKSnTFSmMx
 9S0tn9gxGzmGWg9Tt2yfH+q0oN49LFbW0aa1oQD66MOEhQ8SN18Gv+HffHg7E1uJ8hr8
 HauiTaB6UkkrREM+LQqimW1L2DDBtkO+vID7zpbh1QL2J22edT7W9s1JgjTwojuqY75U GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw58ggx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 20:47:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181KePV3145122;
        Wed, 1 Sep 2021 20:47:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ate04qvct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 20:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FABpHa8sFGn8vgfJlhB3B7RsrG6eHb5qTYmRnD9SGn66BlM0msrBG8XNuDuuoEhBiqMNHLzNdso+fc6UyHqIE/EiiZlqX1dNXm6YkCwvSafSam5Lvq9jSjYj3eBdNlArkh1fV7XYx2jIH3210PkKA7x9dHM7FRYWO5RrN7yWjmHHElphOaBBHOayxY04bqyN8E9Eixh2nASkqyZO33BHiKjg/uwpCghegCs2gIjTY6UoX7kUFRukkp6bPuzQXJ/C4JtOgzJDxs06VNML4FfypcfRESGC2Wk1yuhJDpHcibHK3/YWKDukFrPSclhMBTg9xowgKnpyRcb6ZiHnlnfg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TnkE0UfAF92yOSUC0CHFyEO8CnkKN/rsHEKCtdVkXk=;
 b=GVCUcgQQxb5SlbBUmbr8YAl/cQBSnLzguQkScxPZazVNN8ua4leRVEKwpCmxotDDExww8fEbFalQLATkCaQ9ozttOsjuZsKffU0ByyuouYIMXvf6UH4Y8wv6cLOCJzoRP6zVTFOlWK3MkUu2+ZNfgOycl68ZWZmdoH8j2eYW8zswF3ZvU2myBg0dfTGDM3Gga1fQpD55tSpLTy6ARnCvpmBkpnWgV7XJ5A8mw4YeiNroqvjZu+G0DqIovvCSQCiAPzAj6JTivgNuNh8ujLGBUbHLU1PWaf0G1dyjtW/g5Mxr8tLLu1UA43GwI2vNlOje9HDtQ+vB31RMFfUog9SSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TnkE0UfAF92yOSUC0CHFyEO8CnkKN/rsHEKCtdVkXk=;
 b=gT95fkedN36iv/Ajsc8/BzUo3So8miFIC6IqOPsSXvi/6qIKqdvnJW39rtzDLzD1g9D5+g+RgwXfiQBL1sDti+F2bjbIP1cObEgl4gHCyo2FUOSj6wKYmFPYd9qNdgsxNA4TWzuiKWRZx9VBvPzm9MA/DXZcVEUHL9kQNDn/ADY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4229.namprd10.prod.outlook.com (2603:10b6:610:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 20:47:54 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 20:47:54 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf script python: Allow reporting [un]throttle
In-Reply-To: <YS+AzzoPci74EmWp@kernel.org>
References: <20210817002133.48097-1-stephen.s.brennan@oracle.com>
 <YS55BApYslmJuqPh@krava> <3035e557-9752-9277-6a84-f6d65a6a119e@oracle.com>
 <YS+AzzoPci74EmWp@kernel.org>
Date:   Wed, 01 Sep 2021 13:47:54 -0700
Message-ID: <87pmtshvk5.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:806:27::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.10) by SA9PR13CA0131.namprd13.prod.outlook.com (2603:10b6:806:27::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Wed, 1 Sep 2021 20:47:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59ff0120-924a-41a5-20ca-08d96d89c58f
X-MS-TrafficTypeDiagnostic: CH2PR10MB4229:
X-Microsoft-Antispam-PRVS: <CH2PR10MB422920102BA4BB455F2DD1D3DBCD9@CH2PR10MB4229.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEELjq7EbJ2Ufjovpy5IN9sUodRP35BzUCRaGSI0U9gmQ0Pq69oUZ6EjFoC3m3dE6LIqcGaBQ2S1bFUuCzoe312MXTeZZOreqnXlvQYlNwZi+LeB+I6n6iPeukjdSzWSyCu1j2b0XdQoGucSLR8ZMMNmIoJOyve0aVimenoObLKb0j/Vb21jTZe1qUsDM5H2Dqs9ofShqXe/si0x5m6IpnmJtq6cPbAYiBDb99hrQ/BTPM1KnvCfYrUeZtZes3Qh8Y8rBoalEMWfpiUtEAMNt6J/BTEYxd41ZX0e3yvwuxj0/ewMpIZlMRhPnf+oJyypYuTjwmzoZSQRCiFQViPE5awwDl0pKOxVEQhYEe4e3RTW7nGx4s9dNjmhHkM6D0MYc++qjlwyVFtrrBlqLQtxBEIuRFU8X+gZD7x7ueNc2ByXlrAEyQFKtYzYKDhPjPdgIGVa8QuAGTYTmFcawIhh14R4UeK3Mz/fCmkc0LspWyuNNOKZkFHdz2He411ELwRQDr/lYkiD0WO3O4Gl9c0BzefAkpBvlYUsgwBjOmurwgmcM/jvyU4GvGD7dJqnFprV4LAafdtp4JywTTuiPFloH3gTAf2dB8U+BTTksf2bIh6BejN9dA8snnESzgpUPkdY2arcTgtrqzHK1h3xilNZXUDrOeqvJKihntyemEUMqxmK3iChcMqaBaml5RBbWcJE7tTSzMdPCP9AMgFPk0XtFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(54906003)(66946007)(53546011)(66556008)(316002)(186003)(66476007)(6496006)(26005)(956004)(38350700002)(38100700002)(83380400001)(2906002)(8676002)(6486002)(478600001)(52116002)(86362001)(6916009)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MlB2C31JzVGjTfu5YXtTagIAlF88CHkOQvv/630qjze1YR6pO7j4XSOa57K?=
 =?us-ascii?Q?m1ewbC7UoDJmG3cbVPsFPNyymIsf24zLPpXSera8Unrf5Xu4SkwM399epUP9?=
 =?us-ascii?Q?duGcjXL6PeJlZSlFXfXiXHG0K5u2asbzaIpIBh+rHPQHRsCZQXsWtnHcSOwm?=
 =?us-ascii?Q?P8IXw3ccEJ3wA8PY/H+IqSCOCHGYBDhxmJ/wtDn27+67JSv7D/phms2tiQQ9?=
 =?us-ascii?Q?BCjTf9NNe5y6QXyKDe3y/3TUkIXDBPnNnxH0bz7TzB2T3T6t3VL4J7NVeiv7?=
 =?us-ascii?Q?DhOUUY8rxKZ3VFyVg4u5z2tqIv5eHSJZCak/Jmh/+3INIeTgbDbyPwANEg8x?=
 =?us-ascii?Q?O/rzw34HqiP5A46MQXVHI8zy/cjq6yC+mrUrTNTLuZHxmibA0AG5vnluWgQK?=
 =?us-ascii?Q?h54UdVTFXCvzpx6XHfGBqPLBL5ZK8lph0NBv57fKG6/m+oMwWZ/Xb/tmuZkr?=
 =?us-ascii?Q?eAmoRkZDslL/VY3mcXuGTbzDCuZTC3HcDJVdcjwjVEuBuhI6ozbEzcC2/sjd?=
 =?us-ascii?Q?OZ6scoXNYESPrB2TFHGZn41OyfDT/LQTMAmdkL9CadQ5pPdnJfNEHLtZNDRu?=
 =?us-ascii?Q?EHZcTpqiUsIen1zKO6v8vVt8IIDTe+c1QaLxS/LtKMdIQIiKNsrPtgUZWEHb?=
 =?us-ascii?Q?/Y9Rcit6g8NI0OoxVhjqrfCMPFtqHTONvPp+YzrIaMTHSv3806Ic7QJ0vees?=
 =?us-ascii?Q?3obFrEGVZYL/yjNzX643AsqAIKnbunMlyz/iDrtbZpyLUlb1CO8+R8RV03GB?=
 =?us-ascii?Q?NCacikApdgbCNkqoDEQXh3pTmXfE9DQVPU6AKhBhC9QHfSJRI2s7ehJ2zJPT?=
 =?us-ascii?Q?J0/pJXBjjy9C1TDQ12+849/U3JoN2PJrmDwHE8T4ThWHb1k60LNsgZi6nB6B?=
 =?us-ascii?Q?DMZigTOwtLHiX1Qb6JuobIeIFfbdZ4wWNc6HIbzLaFxkPSmcIMxHO8rbm6mz?=
 =?us-ascii?Q?DPIu81nXmHVlkgZkVsU026nStTxkWzsvgpXd3dfh9Ql2YZCVWzoJD0oEHAPf?=
 =?us-ascii?Q?1dFyCokk49hqWm3XSrVWlvtBjZGMFQ/R+vlpg3O7vsFnEY1HJLEUYeMv0pJ0?=
 =?us-ascii?Q?cIS3bDYjHH+/GKTNlQ6Yxaq8HJKS3l7Z0FzT/myiOEAnX9N/WpYCMzCuMY4Z?=
 =?us-ascii?Q?MPjqVp5bQ2TqFcIpkj/xKd9y/LXzeO43QqW+zuR/ziICTmMepCHoBDWCkMoN?=
 =?us-ascii?Q?wjtxRfR7/NP0amS2QxHmVRC7yVQYdKhLIC50jzcp0SsEmBCz936F9fQ7SBUE?=
 =?us-ascii?Q?kYffypzweLjy4m4GaGoZi9KmuYp46B2IRRi8WD53iOCYPA6LAlPIfYot/q1U?=
 =?us-ascii?Q?lEH2dXlY1FcXammo5Ho1KUyp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ff0120-924a-41a5-20ca-08d96d89c58f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 20:47:54.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah1MN3XGd3PNKsobrPkHyCE75Ht07oNsUYZurJIH+Zg/3X84rk2C+Zf3330m0ASwQ5h8r0MlpndqX/Cg0LcwNOa7QI+D4fZhZyYNpPOljtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4229
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010120
X-Proofpoint-GUID: IjTSpQLwfsBN-5v7wcd8bV7lZflYPx_A
X-Proofpoint-ORIG-GUID: IjTSpQLwfsBN-5v7wcd8bV7lZflYPx_A
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> Em Tue, Aug 31, 2021 at 02:47:47PM -0700, Stephen Brennan escreveu:
>> On 8/31/21 11:46 AM, Jiri Olsa wrote:
>> > On Mon, Aug 16, 2021 at 05:21:33PM -0700, Stephen Brennan wrote:
>> > > perf_events may sometimes throttle an event due to creating too many
>> > > samples during a given timer tick. As of now, the perf tool will not
>> > > report on throttling, which means this is a silent error. Implement a
>> > > callback for the throttle and unthrottle events within the Python
>> > > scripting engine, which can allow scripts to detect and report when
>> > > events may have been lost due to throttling.
>
>> > > A python script could simply define throttle() and unthrottle()
>> > > functions to begin receiving them, e.g.:
>
>> > > ```
>> > > from __future__ import print_function
>
>> > > def process_event(param_dict):
>> > >      print("event cpu={} time={}".format(
>> > >          param_dict["sample"]["cpu"], param_dict["sample"]["time"]))
>
>> > > def throttle(*args):
>> > >      print("throttle(time={}, cpu={}, pid={}, tid={})".format(*args))
>
>> > > def unthrottle(*args):
>> > >      print("unthrottle(time={}, cpu={}, pid={}, tid={})".format(*args))
>> > > ```
>
>> > throttle event has also 'id' and 'stream_id' I guess you don't
>> > need it, but maybe we should add it to be complete
>
>> I tried adding these from struct perf_sample.id and struct
>> perf_sample.sample_id respectively. I then tested these on a perf.data which
>> contains a throttle event. The values which my python script reported were
>> 0xFFFFFFFFFFFFFFFF -- is this expected? If so, I'll send my revised patch.
>
> So, perf_sample.X is only defined if PERF_SAMPLE_X is in
> perf_event_attr.sample_type, and for the perf.data file below it is:
>
>   sample_type = IP|TID|TIME
>
> So only perf_sample.ip, perf_sample.tid and perf_sample.time are set,
> not perf_sample.id nor perf_sample.stream_id.
>
> What Jiri suggests is to use the _fixed_ payload for
> PERF_SAMPLE_THROTTLE/UNTHROTTLE, which is, according to
> include/uapi/linux/perf_event.h:
>
>          * struct {
>          *      struct perf_event_header        header;
>          *      u64                             time;          <<<<
>          *      u64                             id;            <<<<
>          *      u64                             stream_id;     <<<<
>          *      struct sample_id                sample_id;
>          * };
>          */
>         PERF_RECORD_THROTTLE                    = 5,
>         PERF_RECORD_UNTHROTTLE                  = 6,
>  
>
> The 'time', 'id' and 'stream_id' should always be there, while what is
> in 'sample_id' is documented in the same file at the beginning of the
> 'enum perf_event_type' definition:
>
>          * If perf_event_attr.sample_id_all is set then all event types will
>          * have the sample_type selected fields related to where/when
>          * (identity) an event took place (TID, TIME, ID, STREAM_ID, CPU,
>          * IDENTIFIER) described in PERF_RECORD_SAMPLE below, it will be stashed
>          * just after the perf_event_header and the fields already present for
>          * the existing fields, i.e. at the end of the payload. That way a newer
>          * perf.data file will be supported by older perf tools, with these new
>          * optional fields being ignored.
>          *
>          * struct sample_id {
>          *      { u32                   pid, tid; } && PERF_SAMPLE_TID
>          *      { u64                   time;     } && PERF_SAMPLE_TIME
>          *      { u64                   id;       } && PERF_SAMPLE_ID
>          *      { u64                   stream_id;} && PERF_SAMPLE_STREAM_ID
>          *      { u32                   cpu, res; } && PERF_SAMPLE_CPU
>          *      { u64                   id;       } && PERF_SAMPLE_IDENTIFIER
>          * } && perf_event_attr::sample_id_all
>          *
>          * Note that PERF_SAMPLE_IDENTIFIER duplicates PERF_SAMPLE_ID.  The
>          * advantage of PERF_SAMPLE_IDENTIFIER is that its position is fixed
>          * relative to header.size.
>
> There are artifacts here from the evolution of the perf_event subsystem,
> i.e. throttle.id is equal to throttle.sample-id.id when PERF_SAMPLE_ID
> is set in perf_event_attr.sample_type, ditto for 'time' and 'stream_id'.
> entries.
>
> But since 'time', 'id' and 'stream_id' are _always_ set in the
> PERF_RECORD_THROTTLE event, we can as well make them available via perf
> script python.
>
> Take a look at ./kernel/events/core.c, function perf_log_throttle(), the
> only one in the kernel that emits the PERF_RECORD_THROTTLE meta event
> and see that it always set the 'time', 'id' and 'stream_id' fields:
>
> static void perf_log_throttle(struct perf_event *event, int enable)
> {
>         struct perf_output_handle handle;
>         struct perf_sample_data sample;
>         int ret;
>
>         struct {
>                 struct perf_event_header        header;
>                 u64                             time;
>                 u64                             id;
>                 u64                             stream_id;
>         } throttle_event = {
>                 .header = {
>                         .type = PERF_RECORD_THROTTLE,
>                         .misc = 0,
>                         .size = sizeof(throttle_event),
>                 },
>                 .time           = perf_event_clock(event),
>                 .id             = primary_event_id(event),
>                 .stream_id      = event->id,
>         };
>
>         if (enable)
>                 throttle_event.header.type = PERF_RECORD_UNTHROTTLE;
>
>         perf_event_header__init_id(&throttle_event.header, &sample, event);
>
>         ret = perf_output_begin(&handle, &sample, event,
>                                 throttle_event.header.size);
>         if (ret)
>                 return;
>
>         perf_output_put(&handle, throttle_event);
>         perf_event__output_id_sample(event, &handle, &sample);
>         perf_output_end(&handle);
> }
>
> So instead of doing:
>
> +       tuple_set_u64(t, 0, sample->time);
> +       tuple_set_s32(t, 1, sample->cpu);
> +       tuple_set_s32(t, 2, sample->pid);
> +       tuple_set_s32(t, 3, sample->tid);
>
> That may not be set at all, you should do:
>
> +       tuple_set_u64(t, 0, event->throttle.time);
> +       tuple_set_u64(t, 1, event->throttle.id);
> +       tuple_set_u64(t, 2, event->throttle.stream_id);
>
> These can be left as is with 0xFFFFFFFFFFFFFFFF meaning its not set:
>
> +       tuple_set_s32(t, 3, sample->cpu);
> +       tuple_set_s32(t, 4, sample->pid);
> +       tuple_set_s32(t, 5, sample->tid);
>
> to confirm the user can look at perf_event_attr.sample_type |
> PERF_SAMPLE_X.

Thank you so much for this detailed explanation! I'll send v2 as you
described. This definitely helps me understand the data structures at
play much more.

Thanks,
Stephen

>
> - Arnaldo
>
>> Thanks,
>> Stephen
>> 
>> `perf report --header-only` from my testing perf.data:
>> 
>> # ========
>> # captured on    : Wed Aug 11 11:55:44 2021
>> # header version : 1
>> # data offset    : 264
>> # data size      : 18240
>> # feat offset    : 18504
>> # hostname : stepbren-ol7-2
>> # os release : 5.4.17-2102.203.6.el7uek.x86_64
>> # perf version : 5.4.17-2102.203.6.el7uek.x86_64
>> # arch : x86_64
>> # nrcpus online : 4
>> # nrcpus avail : 4
>> # cpudesc : Intel(R) Xeon(R) Platinum 8167M CPU @ 2.00GHz
>> # cpuid : GenuineIntel,6,85,4
>> # total memory : 30522624 kB
>> # cmdline : /usr/libexec/perf.5.4.17-2102.203.6.el7uek.x86_64 record -c
>> 100000 -e cycles -- sh -c echo 2000 > /proc/irqoff_sleep_millis
>> # event : name = cycles, , id = { 5, 6, 7, 8 }, size = 112, { sample_period,
>> sample_freq } = 100000, sample_type = IP|TID|TIME, read_format = ID,
>> disabled = 1, inherit = 1, mmap = 1, comm = 1, enable_on_exec = 1, task = 1,
>> sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1,
>> bpf_event = 1
>> # CPU_TOPOLOGY info available, use -I to display
>> # NUMA_TOPOLOGY info available, use -I to display
>> # pmu mappings: software = 1, uprobe = 7, cpu = 4, breakpoint = 5,
>> tracepoint = 2, kprobe = 6, msr = 8
>> # CACHE info available, use -I to display
>> # time of first sample : 228.321751
>> # time of last sample : 230.362698
>> # sample duration :   2040.947 ms
>> # MEM_TOPOLOGY info available, use -I to display
>> # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT
>> CLOCKID DIR_FORMAT COMPRESSED CPU_PMU_CAPS CLOCK_DATA HYBRID_TOPOLOGY
>> HYBRID_CPU_PMU_CAPS
>> # ========
