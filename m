Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E2C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A5A61181
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 09:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbhJFJ1v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:27:51 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:15160 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237909AbhJFJ1t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 05:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1633512357; x=1665048357;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3nFQQvDkXDtbjVYzzVtjZ8Zjf/bU9PBQYyf8Um1THE8=;
  b=rxM/6YtulZd1+JIrsPwZ+4SWlHecGHsb3/5yQGPA6oV4cXEu3jXPNQh/
   k8BlgdFHaBog9ne4EAcEHZDVlRwtDQ1UaV2lSuK78kAvyj6frz8C8q97b
   SlsdrJbb40Qkbda479jOljBlxvrkaMHn1nwT2ng3VXcICvz8S6GbmKYnT
   czFcXb9Hh0YW83EQAF09XhXhvuoIEA/ou3zPMrvKsvUVB/rVvwCDsQWcn
   kqu7CES6cx3xCDlvHy0LYe/pVj9OOCCnowo2Y+D5ipbfTRyIqYiy6gMH+
   akHDIL+cwuCc7Fmj5w0etbahABHSOX6MUej+mZ2niZzZ7vpniimJlTATd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="40905003"
X-IronPort-AV: E=Sophos;i="5.85,350,1624287600"; 
   d="scan'208";a="40905003"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 18:25:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD7o2sSpT3gXNuA7BMcrThTeveFgipOXXzpGPjb6SKLBMBGVMAY66UFGD9UvSdQ/cXgXr6x3NpUMjY3ae+61uUKk/SNO5qwZQCwWy/GovSNDbq8sQP5UMlChMl2C5FOFyCU0e+WeDHtNGYyHR0Ehi3rQo91wZsajGRT9ySPwv7mZcogc/A81QQ3XDUC5HTvM4LGS2aI42/Gx61pCerqDtZo3Z6wC3HR+hHknqtqRinHxbx37vysMtMQPJ05N/ZAfQXkRjlSi0YP02pb+mAG/ouXUlyY3HKXEocSkakhwIdpCsAouNN4deIr8SqEOn7q677cItSx9DR7TqsPYhWX5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nFQQvDkXDtbjVYzzVtjZ8Zjf/bU9PBQYyf8Um1THE8=;
 b=jcno1X6vPFGZzLNgn3nxp567nXoYgZdgb5lVeqwCaK/PZOjbwc2EvG+1MKbrdFmv7BX0C8USiW4xmFedmSFgECCZJ5VPYV9JTA5H8298d3MslnBmHlQMFW2qFHAbnbSsLTcxV3AmSy2EPvgQ6qUIaEZFM1BwZtbKIfXRQhYFj8Kp6F+CGYjNtoVGNmG1PaC6HtiJrGNuZ/x7Fe8oCs2qbNZWlbks8exmJ5UEkp97RhxwELQuibAULt2vjVsPCyZD0HL+lTsLPrhzFfLjjh0efZdI+YdqdDG1cV0dwLE7FpZMkW7ouXKNpmdREZRWqiWmgR4OiRApqhriYodDtD8nAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nFQQvDkXDtbjVYzzVtjZ8Zjf/bU9PBQYyf8Um1THE8=;
 b=rOZO1vss+YLvOhmCJKKJgRQLU72T1g275LrOtbVGynOIfgiX3T+gl/HphUbK3H15ucNqN936WCtslcpd7NSxp4CrbeVjZkH1NlvAaWQ9HZLAZ8ysOmiNdqtRoIkcZbxvRqmEh88lXFwFToJ8xtDmP+F4NH6R8fhAtYn84O4lz4U=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB4881.jpnprd01.prod.outlook.com (2603:1096:604:65::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 09:25:51 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f%6]) with mapi id 15.20.4587.018; Wed, 6 Oct 2021
 09:25:51 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Subject: Re: [PATCH 2/2] libperf tests: Fix test_stat_cpu
Thread-Topic: [PATCH 2/2] libperf tests: Fix test_stat_cpu
Thread-Index: AQHXupPzxhzfYqxV2EycaFLWTPhlfA==
Date:   Wed, 6 Oct 2021 09:25:51 +0000
Message-ID: <OSBPR01MB46004A88D36E4312AFFA5464F7B09@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-10-06T09:25:51.343Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 7b5bed33-efdd-486d-b48f-355015d22d8a
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 232835f9-a2ff-4d09-281e-08d988ab4a3b
x-ms-traffictypediagnostic: OSAPR01MB4881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB4881A4ABC0857ABF79FE33B5F7B09@OSAPR01MB4881.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkT0qPxSNrW+9ORa2mP/UIp+rBmfsg6Y0V9QKmf6G35eaGlYSJhvV2myldSNdkfMrfZzjwA8vmUZal7hvLZuAP9nowZjVQxSO+8Q7BqppZZPZ8XHtEna/OIYlhurD5CWgzRSC+CllfwluokdXBYG7em3+yef81/AVszLidOgTn1E68TJixwyOJvIHKRBLnCALwv8c25nQr8Fn4/eBQEZNl1tLvkHmnJNe0xwDD5VAwNOyBJiJRr6x9vVnNusdyoraJJykhqsFZFbuyF23ySwLAQVFRHwbUOygYtvMxHLXwRq5P3lHqrNfSmnZxk4TtcHTc0koB+asowV668n5RUuJ+p/un1lupYzEoo3rGBNBgG7GjYah8okMG/zXAZQWdXZOnXsja7nJ3PAAuGoFK/XrR6SEXloysJb3bNXC7EonGkPmS/X72nfJ3HiE9Gv9cPbZ2T3LwEVMr4gnaW/2fNq2O8UJ9eTo/w22AzoUy8yQHEqapxZvuGLMveBrt2TTb0eafbZEp8AQeNYcaGoOW3l62ZIJV9XMNMSswcTmF/8Jt0PrXJ6FCdg6WI0KFI4U7j73N18RAOupuCQo23G+Qbh0doF2RST/Jbm0jnvCq7lIoHylcjKf++NhM4EQ+b/rczT03qUF7TRdKSCnu1j9OUDGa1GUAArM0C0stIkPpWMFj5hoIIV9z/aat6BDw1TzNCG84iEmoJO3KTJTYzOFU3kPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6506007)(110136005)(55016002)(2906002)(83380400001)(5660300002)(4326008)(52536014)(66556008)(558084003)(66446008)(66476007)(9686003)(64756008)(26005)(107886003)(7696005)(186003)(508600001)(85182001)(38070700005)(76116006)(38100700002)(66946007)(8676002)(71200400001)(316002)(86362001)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TVhxcnpFMTdFWjNiM0g2Yk9jS2FnZ3JZdFVZL0VhZ0daUGdPNjFOcnRj?=
 =?iso-2022-jp?B?WEtTVDFzSEplVU8yM00yanBHWFZWVkR4enJGaEJyb1pyOFo1eEJZWENX?=
 =?iso-2022-jp?B?bFFOWVNNN2o3emVvakUxT3JMQkM2WjFaSXUyLzB0d2d6NHhmSGVIMjJs?=
 =?iso-2022-jp?B?RFFMYmFNSGVZeFVSeHMzVlUySHlFbkFjc2FlNGZtWGJGR2tycW1zL3V6?=
 =?iso-2022-jp?B?a3UxQW5NTHJ0UW5IU2NUQU16SnJ3eVNLL0laWCtpdmN5QlBSdEhMaEd0?=
 =?iso-2022-jp?B?NTloODBTa2xubndJeGlhbk1tRmR6UVJYc3dwYjJwVHlZQVc4d3l6OGtS?=
 =?iso-2022-jp?B?bC9RM29tRWk3OU1ZWll2YWZBZndSekw1RGFnS0dWTnhYbVo2SzhoaFg2?=
 =?iso-2022-jp?B?eWZzU1R0VVpQMUwvN3ZQUHQza2VzWlRBTnhxOE0wd1VJRXR4c2pYOS84?=
 =?iso-2022-jp?B?cUc5dms4V0pqV3JMQVgraWxDRjU4WTNONXdjcEVmV2VBY1U5R1diZ3Z3?=
 =?iso-2022-jp?B?dTBROWNjOFhoS2xJbkJUaURuMlpXU1QxU2dQQ1V6U0RBSlUvaENnYy9q?=
 =?iso-2022-jp?B?eFY0SG02MTBIdDkySmFUMS9acTZ6K1J2NHdoUHNJU2lSUUtLejFvNGR2?=
 =?iso-2022-jp?B?WHh5elYxS25FdUpPOXJlUVM4eDloaUlZa0ppMFZBaGtneUxhaVM4S1FR?=
 =?iso-2022-jp?B?NE5MT3RsS3AvZE5UdG9EL0txMWRpc3JEeHBZVnBrRUxpNHJQU0dvclBL?=
 =?iso-2022-jp?B?ZEVFdThCYVZmYXcwL3NFVzdJcEJMOE9ocnJ0QjBTWXRlMktsWFBibmlE?=
 =?iso-2022-jp?B?WXVSVHRFV0c3bFFEcHBGUkZGNDFKQXRVS0lNeTVxUzdKamV3dTNEQW05?=
 =?iso-2022-jp?B?RlVrWklsWkxiUlBieUd0S1dDRWN5Ulp4NmJBYmNvdzhZak1xOVZxb2tV?=
 =?iso-2022-jp?B?TEZzNnNWUzN2MXpJamUwa0ZmNGNtNnN5TzRoamNzQW9vbmYya1JNUkZZ?=
 =?iso-2022-jp?B?TWZxcG9MOHlUanNORWc3cFozTW9ncGRhcXVicXdEV1k2SGxLK3kwdDhW?=
 =?iso-2022-jp?B?TWhJZzFQNjFDdUdlN1RBMEFjd2JBZm5sSktzY1I2eEhUUnFLSmhiVEFY?=
 =?iso-2022-jp?B?clRoTnVkT3pDL0dhSEZJd2NFeU5yU2V4aGVmaW5BV3VNV1FJYTBIVnhx?=
 =?iso-2022-jp?B?MGNQWCtMNStzMUswRUpBZmRpcWxuSmtCNVZUcVd3Z0dkdjBEcmlZZTlU?=
 =?iso-2022-jp?B?dWdRcmpPM2VleXFRTGl4OFI4RFJBamRQZDBtZXdnRWZUT2RJTVZLRmlZ?=
 =?iso-2022-jp?B?cmhudTZMK1Y2dlZUTlVlSzZmSkgzVU9hOG1HWTIxbS82YVRUVWRDTUlM?=
 =?iso-2022-jp?B?eWhKQ3dpd3daOENTcVlIVlZyL2xJNUlCcGEwUm0vRXdkZGtabTRLalJa?=
 =?iso-2022-jp?B?MG5FK3l2RSs1dDh3L29XbVVSU0hFNWRlMWlmUHB6NWlaeURkNmtvbURX?=
 =?iso-2022-jp?B?WW1Oa0tVeDV6L3lxejIwVC9uOUpleWptOEJtZzIyMEh6UVIvRzFhS0JK?=
 =?iso-2022-jp?B?RzQ4ODZPc3U5djZDODFDOWI3ZUVKOUo2VUgyajZ6RStQZlpxeC93Vm5x?=
 =?iso-2022-jp?B?dmlBeFdZU2N1Y3plQ1NuekRNZjNxRjlNVWlLK3ZPVlR4amptVFNiNElC?=
 =?iso-2022-jp?B?TXcvMUlqU0NXQktETGdQT3kzR08vQ0c4QnVGcHlXcktnelJwMlR6M3dK?=
 =?iso-2022-jp?B?ZVI5T2ZwU1JsYkFMb3JLYkNJc2hTcE9mV3dITTVnaHhDUUhibFRkdWtl?=
 =?iso-2022-jp?B?K0Q0bUFqdTh4aDQwVmUwMDZiWnlyZDhrVTlrbjI4NWpYK0FFcG9DRlM2?=
 =?iso-2022-jp?B?Q1Q1VVZoci9rYWVzenBPNjVXdEE0PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232835f9-a2ff-4d09-281e-08d988ab4a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 09:25:51.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bOs7P+8IfKOGIdzhcM52hUbK/Jz6IqZrsDdsEDAJxqEBvBwvJDULP9uWV20KRssqz3QHZxYAjVdelyDwpi69uqGpOgkxy1T7fEuRVOhp7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4881
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I sent a patch with "2/2" in the subject by mistake.=0A=
I will send the v2 patch immediately.=
