Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D971C00140
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Aug 2022 04:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiHOEXB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Aug 2022 00:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiHOEXB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Aug 2022 00:23:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C48014D00
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Aug 2022 21:23:00 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27EMt53a029068
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Aug 2022 21:23:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=145gDdexEVAoof28wVr/wC0pZy1FvylcXqCoxBMvtFw=;
 b=eDAgmnwyb9YBLSPIXnPUSrQC2tzjc51Jhe3xaGZBVPx6L2Oz1/juU/ndnCw/hplIjJP0
 yao7JFVWRVmd+2K4fBznknGapB9Jo8WBh0TRKZW1b95BhFejDLqJaJyVRiFAB+tzKq5U
 5/ki34BItfm4NPqHyFzjhfMPX8qWfxN4hPg= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hx92u07r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Aug 2022 21:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig4yJv5Q7eubhVuYqC4k9wBpTN+r52YmmIUjwstRMY9WzFryRb1qAtvkmG7hPKddjqsxWyt7zizynxKSIBPBEnhy3QY2O21JhncxVkVU0Ons02kk4Yvf3iqFmmpTWgceda4RfH8+Nw1aaBqK5uAQ4vi0pgOTYxvUc5OQUQf6Pz9IzOlOs2t82fdNSSNbZ/qQ74QI6U5lgQt7E/ID4vOm0S0BzQcL5jouGUrLVjYqYj4/3hQvuvAXfH3r8bvd6xSzTkmWaQzrTCZBKqCD/EJYTKUYZkKRBHQWvIw9D4okBdddV505ymz00PqQZfVgL8fqq+k4+ezws3GwyzYmA0vOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls0atGqr9MN8oDPBDxKOspen0HD+YHJuZ2CONdq/Qvs=;
 b=D9EmEp/QFTuQx4OQeD6WpXII7AhvVJNQsYbwRi/4G0JX2+R8DVh7wqzzh7yrP15lSWAvJnWD8+FGLEleLuwZiNmlFGh9h0nySnxQ8A3tfkq/WX6YSfv1gfVxJpSISrE+WVfudfcgh4IHjwrTok3u72ChcHFBF0uLMpRcHIL7thA/MyqwdLGUJHUX5xh5U7zMzSKsxiWYx691Ym0rlkAuec8PaZySEyhnTaOqLQLSJgI1wjjos2ekhkbizp74peswGNlBf37zNKZALuIQ+4T2GXb5JoyZ2zu1/lBMdtfQFZ5B25MAYWek3V+wQZdePes3QD/zqRp8NjR6ORlMp4bVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW3PR15MB3868.namprd15.prod.outlook.com (2603:10b6:303:40::19)
 by MW3PR15MB4043.namprd15.prod.outlook.com (2603:10b6:303:48::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 04:22:58 +0000
Received: from MW3PR15MB3868.namprd15.prod.outlook.com
 ([fe80::d0a2:cb79:40e1:40a9]) by MW3PR15MB3868.namprd15.prod.outlook.com
 ([fe80::d0a2:cb79:40e1:40a9%5]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 04:22:57 +0000
From:   Hongtao Yu <hoy@fb.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Cannot print 'uregs' field with perf script -F uregs
Thread-Topic: Cannot print 'uregs' field with perf script -F uregs
Thread-Index: AQHYsF5YjThkmEpHWkuxuRKOyMn1wA==
Date:   Mon, 15 Aug 2022 04:22:57 +0000
Message-ID: <MW3PR15MB3868A1461BB93AC91C242B0CCF689@MW3PR15MB3868.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7f2adb9-6abd-4c7b-c27f-08da7e75d51d
x-ms-traffictypediagnostic: MW3PR15MB4043:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yr+HnHcseCg9Sc2YhNXo16nYEJ5BaEogwDdIlelRJkp1dAV8H1AupntLFKwGCho9OZctCoD+MW6D2ShutKF4TyhRnjpq33iXflX1SYbI5b6mC1Tu1YxpyjhFErI+6ehfJ+dfPQPs1nKU07hJOUoaymyj9KhY6XMBkh74U9jO1dQnMlg06geaHl252MjSYz7y6zEnr7LV+Rw0YRSx8S+L39Rl62kmJDoG1IEzrAc6BvwtXS9+yBem8laKvhl/zi2U2Yy3BGGaA4UmVPHOribRIRhy3mxfQXpADZ3Em2SYKCdyYPVTbRUIbJT6tRbHkCXIpTEYffsjCj9O+ad2Ydsv+oQeqoQjSyPlmY8fyjreSRc1E96ZT+yzyjv6FlKclzalVvLsxISdFdj/9AbuI8We18iJG7226Oz13WpO7Tlxub2dB2HwjgEBqSwtBdc6xBZDg1vS2tKi10Mwv9Fh7ZX0SO8IjDXd11SrAeo/Vj7FC/jk6Lso/ri+j37aL79uEp+hWVBc/98pvySGyDGwdr1zfm1skCd8tFsk+X422zDNv1TzBT6vC46yjVlkfF9fHyA0cGyn2ZYtmTS/DlvtggbqRJbrvi1idANS4pgd4Knv0/kt+a+/W1zgVSgVklohXjq87ImuV3RRzXNKqQXZVYqnzY5h+yLOtVitb05AksB2SSVOLOrFkhR/N4VfSG7cThIfiC/6euMwgZK8X7HK23xmITN3iWhQ27ns+cELB9kOdKHHwNsriW0rWEKhYKqgE8fiNjp/Ijj9bPIgrEoPxaxtDjqQGUQjxSMm3FmgNW64GSe+I3EFA4oCkELdiLG4y07cLVoaxrscjsuyW4hSkmhEkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3868.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(316002)(966005)(38100700002)(6916009)(8676002)(91956017)(64756008)(66446008)(478600001)(66556008)(83380400001)(66946007)(76116006)(5660300002)(33656002)(55016003)(52536014)(2906002)(41300700001)(8936002)(4744005)(9686003)(6506007)(7696005)(122000001)(71200400001)(66476007)(186003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?tS8xefNtXPhR1TLi5omwnosu3Tu17drLCXQrSiqoUTKo+hUPLWtGapvy?=
 =?Windows-1252?Q?qrZw+oymsL9B3OdgGmlKsL57ekyCgzVwWk1SoAcwEdJL+gowib+hYtdn?=
 =?Windows-1252?Q?iJS4ocnIz3hBPl81/jD2kducHeWLzj0zJBIWFxIjFje+7w/MnOUyJv3+?=
 =?Windows-1252?Q?PkRiDyjB6bBgcjuDB/o0q4tR3GnjA+fCb+e73ew58Hy0yEocGYmZzzIc?=
 =?Windows-1252?Q?J9PqkwZHS7coxMB5RODxEplpks8XA1Twn0MihGGsE4aBPXX8HuFEggtE?=
 =?Windows-1252?Q?S41DixEgaDr6eX2MDj1RZivrEJJ6zN+XPoasPYeIEm6XAFaiJ/F5h/Uq?=
 =?Windows-1252?Q?EKuB1WrYZaERo0pKL8FfZRRqHVeVet4mRZJlKZ8nvoAFX2ndG6TxFT/j?=
 =?Windows-1252?Q?hsR6Xa2+doeSgNQRVcZOY318vIpqP00D0hf95h5NqgcDOU+SQH7h73vg?=
 =?Windows-1252?Q?sWxV7K5eK8CLpOxBwClQ1mQdcgwGCNc806wcGTg3JaM2gTQCSjrtk5tZ?=
 =?Windows-1252?Q?lo/rccoxjJpOziGld0n/DHpHJ97l0DBr2DNphE/2fpqakDWTaC8N7h7z?=
 =?Windows-1252?Q?0Y5Ki/EFDSlOwApIzWPGW9rB3rEIxaOmQSl9SBqKqsPCZIIJmK9ZdDez?=
 =?Windows-1252?Q?p49UlQPyu9OCCG1yRGqahrfLXVmrf3imDcqHZ0KBuxB/8UijFJ1qhlsY?=
 =?Windows-1252?Q?FL37jEmWq2bnB4cePaAEKKgw3GKqJ5gKdtHEnnGXc98uNQNcdwjpA4Ho?=
 =?Windows-1252?Q?3Cpoo7/GlIabxrQXAEKEMGtAi4aHDwvmQkhfsyv7nI4KqN7GY2BjQhhj?=
 =?Windows-1252?Q?4RiLZf6/OFhcSUsThwa2h10sJP1FB+QYFhYX19lquQhyjjDQM9mwrlLc?=
 =?Windows-1252?Q?thqpxL1YT+Zo4YOAeOMU1PKqAlndZ4nm+HvrLFCrdsAbttuBkuwb4rGq?=
 =?Windows-1252?Q?NeJ2Gi1aLvitYCM4ep4EdYyYjw/ShPfyvGkKcU7LLWh4HJZrUkkuRpqv?=
 =?Windows-1252?Q?32rfct1H7cRdhbhhNM22OmydQMnqUEOmmH8aNkc51r7yBnGGgq8Yj0f3?=
 =?Windows-1252?Q?BMcuoomQGMOOvZX/1+KZ06OXizkm40UTHvPRWsg0MMMUOZZSYXq+vHKI?=
 =?Windows-1252?Q?KHBUydqz6nu3YovtdmdnJiGICgbMjOcxNzIxRbSU8UrpEkmgAigl4SaO?=
 =?Windows-1252?Q?0N+/6DhCwZYRfGbb3PoHAuHVcbnxaSBr/po39STrB1oaLQOG+gcT/HS+?=
 =?Windows-1252?Q?S/454JK9arWLNe4XJjFKlZHDa+7D6RYxkFRgvonl7Y1Yde/2PaNmc1xQ?=
 =?Windows-1252?Q?IzXoSsUkvkeMEMbqy/jXccdxXpMZk5UvtvixE9dVM/kvcmMDaqYaTyNU?=
 =?Windows-1252?Q?NXYKqWARaKOSGdH6iBO0aXdoQdNnFQAcJdskRUeFlnOde6Ze0/D86GYg?=
 =?Windows-1252?Q?W3TPaiZMUEym7qpWIRWXz5CWHOV93RykYxTg7fTCNCE+DLVWgx5qrGMA?=
 =?Windows-1252?Q?ZEW2Rp4V8WOsBjHCdDN2TVf1tgMIHJaft8dt1s8DHg51Hmu8vHimXo0K?=
 =?Windows-1252?Q?n1RjM4/jRB9AGKk90UqKXYKUAl+UOqKF9r7McpC56JIvTYQk2+AnqnEw?=
 =?Windows-1252?Q?YsEOEwdrB79H+tdFlsf336B+amZcUpgQ3qNrsfx6C19elp+C2Xuy1Hey?=
 =?Windows-1252?Q?F9kMkcmp6vBmIzlUBq7mHLA7RZo2/dX4?=
Content-Type: text/plain; charset="Windows-1252"
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3868.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f2adb9-6abd-4c7b-c27f-08da7e75d51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 04:22:57.7492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BO46dfATqE1kXmkF0LwDraC823RFQ9SEqBnrHcsJBUc3SjNmA3LJrsUUAzmHbDP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4043
X-Proofpoint-GUID: Teg97nXLWHe7lBcauM3zeQIYA-Su1Ypy
X-Proofpoint-ORIG-GUID: Teg97nXLWHe7lBcauM3zeQIYA-Su1Ypy
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_03,2022-08-11_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
=A0
I was seeing an issue with =93perf script -F uregs=94:=A0
=A0
Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print =
'uregs' field.
=A0
This seems to only happen to a perf.data resulted from a system-wide monito=
ring, e.g =93perf record -a=94. Per-process monitoring works fine. By searc=
h up online I see a thread that could be relevant: =A0=A0https://lore.kerne=
l.org/all/YVNq9av%2F3Lwmom4T@krava/
=A0
Can someone please shed a light whether this is an issue with perf, or some=
thing wrong with my perf.data?
=A0
=A0
Thanks,
Hongtao
=A0
=A0
