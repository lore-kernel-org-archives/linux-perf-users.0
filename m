Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA044C432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 09:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C1360F3A
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 09:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbhIAJqO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:46:14 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76]:9348 "EHLO
        esa5.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232817AbhIAJqN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 05:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630489517; x=1662025517;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=FM+dq1cjLgdFECqW4FE+6IN7pHzGxQo2eDcX9SnZBKo=;
  b=iKPnX0TWBXsofvp0X6HghJqKRJSczNd24v5Kjm4vXs4so+IeciohCKzS
   cbLvrICNlh2hVbMxe1lF7FnDlDoEDDH1q8VU+SPMbm2WtgDynXPiL4qsq
   I7sjUR2mIDquoVU7NNyxieLk4Gkp27Jev/Ph9g/SMr+I230VwGsr8wcH7
   RKkIVrbHzwpElDpV/5obLa8eIyqvKFIr+2zxhH9fE3pIib2j3FE4L0Wf3
   aCPGX7CmPAjqWSk4Gga40OUYR3RaxIl3Gdt8tZihC3O/Oboy+P7rl13zU
   FU51s5DyyLhMuozZshw4brJnJ0Mi4jibssNqRUlVGi3WixHx+Gzmgq6U5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="38291856"
X-IronPort-AV: E=Sophos;i="5.84,368,1620658800"; 
   d="scan'208";a="38291856"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 18:45:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZwy35EGUhB9Wb9MqmboBI+MFOZNv4hiB1TByDUCmGt3XdvB3zPrnQBFFBrMOaO2R+4rYqe/hBp1Hcr2Jf1+7DtaaC7zFyorngvf0NxzyBnEiUka1LhaaI0ndjMSxvTz94iw0+Tuwy/qA7erZt1g93LKFb9TnO+B+1uyIli/21ADhvz5AOxhnSnYLPNyAKHRjI1wGPV9RNyPOXqbmAyBcaWW5bMNeL4y9dYaKl4AfQIAYLV/O7IGaO4D6Xl2IHQk2UTBY/8nFleVpnktOHXtivTVnxoAS8JPBoqJMr2IGQqCcDegI9eWN9pAsh4Jve3EnL7PYWQy4pnlToiFYhUaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM+dq1cjLgdFECqW4FE+6IN7pHzGxQo2eDcX9SnZBKo=;
 b=kWfXw5hIZPRa58zmvci62cQwERs6aAu6MVhTCByLavsFdDtSdZU88MgxQNlDUhDHLZMzP1PwbnLRr5F9ujmqVJ+xaPYXcMKP80YuOQaM4aGgkMW7eJqApnA42sX+hH3gBQOIxQADJFVIzy3mnbgZCgvpUvwxVMPSneftrXuExCSvRXVzVGfeFdjM7evFr0U+ekx9fxim9HqNczq/YVvQPcrJoHUdS/d+sS/dlkTb5wl73gAjX/4GZKHbOCGGkGjIoM/k/RhjqE8EXy/MBuaimqF6smepHMX9rnYAsT/c1A9ygPmnCbg2bktHfMFn8MVXwQ6n1oFxYjMjZGJO6kZaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM+dq1cjLgdFECqW4FE+6IN7pHzGxQo2eDcX9SnZBKo=;
 b=b5JuuGBr53jt8LuzO9xGLxD3ryxt7c9BGHDnIn1202JJudZoFOZUQI7C3KTIPj7zkGK+gOqvu75JvkGiMuh9KCllgJqiRnaC56lYcCLRZUF1nIH1yE15rWqtOrITb6CQBpOpjOY19Mrm3wsFTBudDayirrf1KfWlxS+DZIPcT8o=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB4068.jpnprd01.prod.outlook.com (2603:1096:604:31::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 09:45:10 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::1906:fa19:335d:cd30]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::1906:fa19:335d:cd30%7]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 09:45:10 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: libperf: lack of interface
Thread-Topic: libperf: lack of interface
Thread-Index: AQHXnxU1v7C7yDhEy0Gzl7rxTcNZhg==
Date:   Wed, 1 Sep 2021 09:45:10 +0000
Message-ID: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-09-01T09:45:10.078Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c312cb9-5d1c-4b37-fd1c-08d96d2d30a1
x-ms-traffictypediagnostic: OSAPR01MB4068:
x-microsoft-antispam-prvs: <OSAPR01MB406853E91A2DE27E756AE50EF7CD9@OSAPR01MB4068.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6kJHouHPWuHN7NdK32U1cqxWtz4RT1VlhmY1ng91xQPn6xaLlIkTATQoUE5ciMZ0O2AkBHpYGXT78/2o42iAjSvFhsGNW0IR+5ZdhFe7W9w29SM94fqM0npDOkIFs9pdUe9gWwE8BmTRNLvDZhpBajHxEhYaxd9k0SPEseXpkMVU4IUrKkbsbe38Lz7aTcu71KnZ0IvbKBJoW8boopG1jEfJCad/G9loOqSCzgp33qtfVsWcxzg7Q48ttS9LXc9HlesZbUJsreoyIUBTvquhs+LjRdlRPqLJ+X94blqlx18n7ykemuv4LaLDqm5h8Wrb0pJJ3aS0uUcIK6/p96ffPHYrF2EvvIyGgdNznUIIDu0oPFAbZ2zZCLS6QC7HdAarSLUx1N/rehmbVM9y864m/HZjLtn5xHgnMGSb7o8X3wO8kcaoPsdC4qparFFEFDg2I424eadwGIT7Lq80exoLU+qvX7JoODxVqJxYirCe+p/aeU9fIrXxQbtH4NlNRgRKdct9RFzKrIavGJBxdE5P1IuqPOx+bffj6S6KUtyngGyKXW/t1odDKLsvbzuWrgfva15W/0f3n+WKfrYRn8ddKO+e8P+Xzh5Nd/qwsoyq2EpBcVhl20A7WcqCN8YQ4mRJEwrhzDlJ8pXTAWRxae1cvag85rFEpv0g0Su3TjET+uGriXy+moC2k5CRRjshBRfmVc1EgcB4CiXIOc+l8AexTgRDZYwfScxE9cML1ABdBWAzb3yWkllyrUQgYeFD0FRs94RWij9RMvFeYKNcDHSaxKhTo9nfMKgVKw6yy4aZrx0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(7696005)(52536014)(2906002)(64756008)(66446008)(66476007)(66946007)(26005)(8936002)(4326008)(76116006)(7416002)(122000001)(6506007)(66556008)(5660300002)(186003)(316002)(71200400001)(478600001)(54906003)(4744005)(86362001)(33656002)(9686003)(55016002)(110136005)(966005)(38100700002)(38070700005)(8676002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SVVmamxxM0JUVTAxZWYyRHMvMlo1aDB4M3VTWExuTzBjMk5xeWtSTmIv?=
 =?iso-2022-jp?B?M0JvV011VU1FcEZDMWsrVnpxa1k1cGxSRlZNajdoaDU0Q3RibTI4UU1N?=
 =?iso-2022-jp?B?SjNscEp2ME43WFovb3NQZWVGRmpzelc0Rk9UaDIwQUt5OWpNTFZNWGVM?=
 =?iso-2022-jp?B?M0Q4Y0Q1YWQ4d2RoUmhLdjRKdlp3TElhNUJDNUJJZ0xHQlF1MDRFV0xP?=
 =?iso-2022-jp?B?bzVHaUw4UmtLUlEzdFRBUmRMazVOMFFYS0JzbFNjU1BWMkg2c09MbWk4?=
 =?iso-2022-jp?B?NTkzM05xU0w2NG44T2pHVi9IQ0hYUm4yekE0ZFdCRzhVMjRJdUVhTndD?=
 =?iso-2022-jp?B?OUF4OWZHbktIRlZENWVQd3ZxNTlRdmRMWVNrbXBZZkZJM3doeDBweDlI?=
 =?iso-2022-jp?B?U3llSjI5UmhBQzdlcUtIN0tnN3FvUWh6ZzFxemZ3RzhqelZZOVF4S1hG?=
 =?iso-2022-jp?B?dCs4Q1BoWVZtTDJHZ2xZN3F4UXVzTkJ6SUxnMGtUNEZGYUJBcU5YdmdV?=
 =?iso-2022-jp?B?c25yemg4akh0OEdJY1J4VG1vaXRtU0ZHb045RHJtMEppSFdvbVo5YVcw?=
 =?iso-2022-jp?B?NmNXd0wxOGkxWThoYkFURkV5T1d4S3BFazFXRU8wb0tGSDNiVjBZa2ov?=
 =?iso-2022-jp?B?cUEwUUlnUkJacXNhYXpyUW9TQzZ3NGZydldnd0JNb1J2UGNtNnNXMytK?=
 =?iso-2022-jp?B?Y0ttZUhlUGtJRm5LM1lPeWhYaENLKzZidGdIeXRScXcrbEUxaWtabElQ?=
 =?iso-2022-jp?B?bDVPUk9KVzdJa2xBcmJjZ1B6eFVRQ2R5dU9pdldFT0F2bUVjclAxZTJw?=
 =?iso-2022-jp?B?VlB2dEhhZHh0UFo5THBCYlVTakl5ZjMxSzlDSUdwaXNYWVJ6OFRpNUZv?=
 =?iso-2022-jp?B?c0ZjdHpvSjdmNm5NME5OemVlTGhkV1NzaTRQTkdWVEY4bG8vTUFrRkZw?=
 =?iso-2022-jp?B?S2VNY0IrYVlMVnV4U1JWcDY3dVhYTXNDSVBXQkphS0w5WUhBVXVQRUll?=
 =?iso-2022-jp?B?UFk5cnNrYVJlWFh2Z2hGbUdOeXhjK3ZXSk9iUjVEQTRHV2U0RHlqQS9P?=
 =?iso-2022-jp?B?N2RjaUszQ0huSnJXekdFWVlEZG9PdGtJYnRFZ1VOK1JDS2NMZ1ZCM1I1?=
 =?iso-2022-jp?B?UUpUZFh4T3I0ZUxaN2xFeU9naUJJYzZOcG8rVjMzT29RTE0vTmtuS1pC?=
 =?iso-2022-jp?B?RVVNbTZ2clBxWkJYSXIzcmNIYVpNK1kxQjRlWWxoOG16Y1JnODNJbHBM?=
 =?iso-2022-jp?B?YmJPVUZncnFLVC83Z0l6RjU5ckYxSG0rV2VSbVZMditCaC9aYXFDVzhq?=
 =?iso-2022-jp?B?OXE3ZnBIMGU4LzdjTnd5eVJnZVJ6T3lMenJTYnZ0ZDhramVUNjFIdjd0?=
 =?iso-2022-jp?B?SkpMaFRvOFZWdmo5Umd4YUkzVnNuQi85VE15TXEyemhJaTRQZ1QzMWU4?=
 =?iso-2022-jp?B?SWhqaDE0cmxxWjlLdlJFTTEzSzRzWkI3OWp3c0NxdEs4WEFTY1MvMllI?=
 =?iso-2022-jp?B?ZWZ1ZTgrMzFWQUhLV05MK2dQb0F5WlNrclBCRFcya0xBNytrQ1FFS2dm?=
 =?iso-2022-jp?B?SGJhVitOY2tOejlZV0dFNzFKYXZSbTVPSkhaUHdLdlB5SVZUZ1JaQ0VD?=
 =?iso-2022-jp?B?K0lRYlBXWlBKQmowN0g3ZmN3VGZiTWQvdlUxSk5mU2FrUHVXL21JVDVs?=
 =?iso-2022-jp?B?RHdQTjVYUGFlTUZWU21MK2hzNEd0TFdTQlNXemVWSm0ydzhLYjkvYzVj?=
 =?iso-2022-jp?B?OVQ3aWFzUDNSYjVQQytuVlRQeUR3QmM0OE8wajcvOWNKV2tkYVZVNE8y?=
 =?iso-2022-jp?B?SW84b29namJVSTJaSm40R0RXdHJRT1ZWd2NaV3hvclpCcE1TSUs3MWwx?=
 =?iso-2022-jp?B?MGJsY3lFSlZaTjNNU1hBaEZidVJzPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c312cb9-5d1c-4b37-fd1c-08d96d2d30a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 09:45:10.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QO6KRzXjZPLrGzSanxtQNWGaoPZ/+QhsJyrYmQ73gg60dSmSJuUIHY3DT56KEzi18HhoTiPL50buMflSmDdX8WOuuk8nexYYgrYhF6Ho5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4068
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello.=0A=
=0A=
I'm trying to change rdpmc test in perf_event_tests[1] to use libperf, but =
libperf doesn't have enough interfaces.=0A=
Does anyone plan to implement any of these libperf features?=0A=
=0A=
- Interfaces that can run ioctl (PERF_EVENT_IOC_RESET) from userland=0A=
- Interfaces that can run fcntl (SIGIO) from userland=0A=
=0A=
[1] https://github.com/deater/perf_event_tests/tree/master/tests/rdpmc=0A=
=0A=
=0A=
Thanks.=0A=
Shunsuke=
