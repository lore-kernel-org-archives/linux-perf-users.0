Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4539C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76F9601FF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 12:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbhI1Mtc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:49:32 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:19756 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240578AbhI1Mtb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 08:49:31 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 08:49:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632833273; x=1664369273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k6BPdJrgm5QgJVuqwLs1EQk47yfO3w6PYv2n3UE/5S4=;
  b=s1oVKGXl1RfuLwyxnjr/AHF/zCk8Vv49fQwPG+FlsMNxudzKMU4ESjaS
   nZRgu9nfNqSbejf7EXNK3k5CDbGXBpkxVVsoX28C5GrLB0eODGdi6TuZV
   ka5zS83ab1CaDnVyLcVnEZ3JFCBUEgUfsbmvW6FRQMZ5gnK2Vfx9mDahu
   wPaXHOn8sf93wmzZNLoJg/ENEIv1CYtjSSkbw5rjkC3O1hHPiOdsaWsqh
   ouIgvt3PEwZSsW2yNRfetEaND6yh7JoqTKwRfqB/bxOoDuie3lXku1Mi7
   Y2pFQ5hFfIIy7HYv+dXEWr3rEU+ojLeWhBNx1G38mJs9vKuZzrlqXrsd+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="39938021"
X-IronPort-AV: E=Sophos;i="5.85,329,1624287600"; 
   d="scan'208";a="39938021"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 18:53:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMd7kbfcSm+xsRjY9ydG2fyM1pT0ClUJYuAGB+Iez+5kQ0NGWtxt8zo5zdltFPVxWMP3zy4fkwJpqFksBt/tqdLNyICagLe7N8uXzBjS9e9QCrfVY1949P3K69G8ATd09Hc6SCzTDWbB2Zl6hG57qF+oaRi3dzcoTkwcW7BIndml38gxxK3V1N4T+K/f6YICn8m6cBZleIFbzjGJAXAVwcJzBRX2hF6xNgGeue02nh5fQFnlh/iz2cgtQwNWT0Zm9ji63Y9EgyiVQJ4/BGFfpjVGl+wjoe+n48qJprP2jReezK38OhnJT27ZlvGG8L7ZjTOF3holK/ItKJb1ZHBnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=k6BPdJrgm5QgJVuqwLs1EQk47yfO3w6PYv2n3UE/5S4=;
 b=MpyuAG5Hz+HouJSbBC6JoBwed8VqmGrLdbafhVu5XlRy3oTuZDGZ4DIIptnZH2gYzLHbIOaG5FcEGW1WgF3z1vzodbSQZzeijiwarq45TGlLB4xSeEe8Q2YBGZfQUqTAwii0MLLZJREYzCB5ONaYeH/RxcwaVSphSF/VNZ54USpPVlFvJH2TAEAllyX71B/thtUUyuIQQMSEfPseM+ffxOERNu5i8a8DEi/Cw8JlCu5mTVQqtFygLWY+ycMHipx2IL+PF7rf22bhZNWoiCU0iylrT93Em2fWx5Q2N7bsTWa4GXk9q6MbNMxlutXoF9jsHhMsVbGlfVwjRlP+bxMV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6BPdJrgm5QgJVuqwLs1EQk47yfO3w6PYv2n3UE/5S4=;
 b=d3hwDDP+rn4bR3x+EYPHKiaqzeycszPN7YFlb05sxL2ZjIG35OVl7VeAVMcmN3AnqyN2BVyql40v1YFdGEevtHTDjkK/ZvXxCHhk8UqWoNEaILrAcrAJiaNHMFdIqxoTG/Gfio+k9xHMWGD/ORTUwEPHM72jednkN1DuGpzdfek=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS3PR01MB6545.jpnprd01.prod.outlook.com (2603:1096:604:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 09:53:24 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::3095:f944:a8ec:f136]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::3095:f944:a8ec:f136%7]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 09:53:24 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>, Rob Herring <robh@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Thread-Topic: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Thread-Index: AQHXr/my+5dH1blYnk6QsbLwDlVC2au5Oj0L
Date:   Tue, 28 Sep 2021 09:53:24 +0000
Message-ID: <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com> <YUuhe7e0J0PSea+b@krava>
In-Reply-To: <YUuhe7e0J0PSea+b@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-09-28T09:53:24.206Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: dc20e11d-05f4-c4fb-7d1f-5b5b79bc9f2b
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b9d9b33-2f1b-421e-3368-08d98265d04c
x-ms-traffictypediagnostic: OS3PR01MB6545:
x-microsoft-antispam-prvs: <OS3PR01MB65452BA1A107F5A7A08A8F87F7A89@OS3PR01MB6545.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZNUVB2gqQhY08bZh/aqhfs5HcW1RKzM/RrDjL+lmg0sV2AY6ONEnSZuu7OKdnbx2NKr6Jtk0MKri7YzBC4CvsN7UNB2IPVNJUpHmj+/fXZbDt1lUz2C9R4Gs37VkGWL0O0x13in28vDUBmSHWbLX61xPts0Wnhnk0uX1DLiwld/4o+HdwpZEjUMZbxOiKgsRHZ3umCg3GlEZoceB7IZQ56xQyrdXG5MXojETwTPs75Xkne0IAuvVf0eylr0ZllHz/VPvmgQpvrI4B4eZTHYlxnRAhCaPZ1Ky4FCvt1IMPxZNZywLxWzyCVLIIaSE+JvcRYntl7NWWYLk/iCJCIrQPbAad6dy2rM5L6T0kk/1EKr9GpHI+9LWNxQrHLmROQqHuhuL757uf/bK6R4+I8sQcKdVwwD64EgiewdRKgTxnXvAJF/vJV4kMs6knDRWoISr4rrorrgMRyan/kK2t8GpNT4DgCg/HeR3qYosWh0qcq6LhRDd2ujTqWUPrOm47YKPrvU/PXj9H7dV1vmOLGOgZ1cYE0btGTyEYVYLd0hF3viCxg2pctM5sFlrCIaQ6DY8EVmht6K1C9Lm+3/Du4O4sKa44pt+UWMpeMhL/du5dDp01mLDfzRC0Nu/j4NJCgSdOSIWr92sGAvoOpAMsoJF72UTjWZfrLavZUmghIdTgfYgl6kXmReZjS9/2Vza5cyYPsZzwZYSLau7dhT5PA4JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(71200400001)(6506007)(38070700005)(8676002)(7696005)(8936002)(5660300002)(2906002)(26005)(186003)(66446008)(64756008)(66556008)(66476007)(66946007)(9686003)(4326008)(52536014)(55016002)(76116006)(83380400001)(33656002)(122000001)(85182001)(86362001)(38100700002)(110136005)(316002)(7416002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHlSNTc5VEdKRmtaa2pVelBLclhGVGxUa2V3K2lPeVA5cnFTVzRTY3dMQXBT?=
 =?utf-8?B?aTU2WHJnT1NKcWJKWnRWYnF1U1ZXWWtxZko5MjlBL1VNb2xHQVdDSk1KTWYr?=
 =?utf-8?B?cXBsSnRla2JTS3JIUWRaWlZDemdoSlFkZ1haRFRzMncvZ3FNTnhHYW40NjFS?=
 =?utf-8?B?RmJZcm1VSklYK1FpaTFqVUFlSU5rVHozR3YvOEwxUlNnbi80eHhGbUlzYW5D?=
 =?utf-8?B?T2JrelFtNmhrdUR0bWhxR0ZxK0FKaEQwSWhIdktUdC8zVldjNGdVMDZEZjZZ?=
 =?utf-8?B?czQ5Q0UxNEl1WW5DOTkzVVpHOTk2RkxMRzBkWVY3Qm91S0lIN3JpclFlSjNk?=
 =?utf-8?B?UC8zeTg3RmQvdjJzZnlocitQYjh5TjM1NndhWkl2NzRPVkI1L1NTODkrNEc2?=
 =?utf-8?B?L2xnSHhTVDVMbXZURHU3eVJLTmRiNTNhVmNjVUJVcElPME43QitBTVNIaldu?=
 =?utf-8?B?TmdYYVRIeUJ1RTl4a2dNWUtpNnkxend3TjhGclIrcktoZVNmbmFyL2t5ZFY3?=
 =?utf-8?B?ams3QzN1R2txUVcxc3E1cEhGTDFtMlJTcFNkZkVmNk8xTnBHTEdSMHdEeDIy?=
 =?utf-8?B?OTFSOXlQemlmSktBU0NxR0xNWHJsWVlaWWE5MFl5ZExqQWsrOXRMNStCM2FQ?=
 =?utf-8?B?TGUzNGQrUnRPTzR1dHhhZ1ZiWTBKb0VLeG1CSmRLdWVYTnFtZlZNK2Zjd1Nm?=
 =?utf-8?B?dzRnRzdFblBCT1dzZzJNUUxZYnhyZ3ZyNUNvZDdhTVZ4V0prWWVuVnR0WUtW?=
 =?utf-8?B?RFowZmNvbVhLT1gyVkcvaFZJUFNSYjRGaStIVnpkcktiby9FQ2RDdXJTaTVN?=
 =?utf-8?B?S2poSm4vQnRGT2pqdThMeE9rU0VuRjBYNDNMUlFMbWhiL1QycmNrQ1VqMHRV?=
 =?utf-8?B?RE5aS3gvTWFraGZHUmNSQVNHSEFYOUloRkNEUmpVTExZMjdUbld2UFlzeEpD?=
 =?utf-8?B?ZTcrdHUzSU85c1B1TC9tMkNnR1MzR0orQUhZMmM3VDBqVFlPTWQ5RGFDY2RQ?=
 =?utf-8?B?SjJDa2E4U0ZmR3VrSkQvYmRES092Z1hYNllBazI5RUZkY29Pc2MycFZQRlNn?=
 =?utf-8?B?c3JIaWNSbEdZcjlUdy9ma0pzUWpmdUd2Y0xGL0xGdTZoTXV1UHVHcDVydSsw?=
 =?utf-8?B?MXpwWEU0S25ZU1BOdDMwQ2E5alhMUkg4WlZ3QmFsZFhxR3BRdWh4RWNIMFpv?=
 =?utf-8?B?T2JlVmx2Y09aaEpuR3hlRHFJVGdTMWQxUUJFcElDSW5OZXNHbzZ6UTE4SnNH?=
 =?utf-8?B?UlRUaVlNTStYZGRmeEFWY3NnNlhYZzRSNkVEZmU0ZnlyNU5aUld4MG1YajA3?=
 =?utf-8?B?T0NDVk5jKzhzVVc0SlRUdEdoU2EzNEVNWFU5T2V4bHlKV0VOcmlPNW9HNXNN?=
 =?utf-8?B?VVpXQSs3c0VYek4yZVVGa2lvdmxZQjh6MFpSRGZmV0NHR3BVZW1ZQjdHZ3dR?=
 =?utf-8?B?ZmQyZDVsVHd5VTlvZU8yTVJ1TXpGaGt0NFNqY0NzUElWWkRyWExadEgxMVJS?=
 =?utf-8?B?Rk4ybEd0emxuTUJDVzNnWjJBTGpSU2N4Q1Z1QzhjbHVBM2w3VVhTbklZbWpX?=
 =?utf-8?B?bWRwKzQzVXFSeDJiR29iUHVVMEoxTkxyVlN6d1NaYmtGdlc2OVRsbkgyVnBM?=
 =?utf-8?B?dmpKelJrVTRmWmFDSWNhN3FCSmVubEx4c3hvRUNsRWxaYlUwaXBxSXJjMjhx?=
 =?utf-8?B?bWlLdUZPMW41RkVNZUNIMmZMQXJwSEZNQjZyajVjRmFZSkEwaW5FaHdiYzVC?=
 =?utf-8?Q?Kd9cgkxEPD7HQ1s0q8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9d9b33-2f1b-421e-3368-08d98265d04c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 09:53:24.6069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: skFu0JXbGIR1bLE08dc4pqUSGRLLJwpyuNzCcfsjw/6V8C8A47uuod6qbzpeMeAvnSelupiDPmrZyt6ndQgeKq28A//Sv4gqySLXuSzeWJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6545
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgSmlya2EKCj4gT24gV2VkLCBTZXAgMjIsIDIwMjEgYXQgMDc6MTY6MjZQTSArMDkwMCwgU2h1
bnN1a2UgTmFrYW11cmEgd3JvdGU6Cj4gPiBGcm9tOiBuYWthbXVyYSBzaHVuc3VrZSA8bmFrYW11
cmEuc2h1bkBmdWppdHN1LmNvbT4KPiA+IAo+ID4gcGVyZl9ldnNlbF9fcmVhZCgpIHNjYWxlcyBj
b3VudGVycyBvYnRhaW5lZCBieSBSRFBNQyBkdXJpbmcgbXVsdGlwbGV4aW5nLCBidXQKPiA+IGRv
ZXMgbm90IHNjYWxlIGNvdW50ZXJzIG9idGFpbmVkIGJ5IHJlYWQoKSBzeXN0ZW0gY2FsbC4KPiA+
IAo+ID4gQWRkIHByb2Nlc3NpbmcgdG8gcGVyZl9ldnNlbF9fcmVhZCgpIHRvIHNjYWxlIHRoZSBj
b3VudGVycyBvYnRhaW5lZCBkdXJpbmcgdGhlCj4gPiByZWFkKCkgc3lzdGVtIGNhbGwgd2hlbiBt
dWx0aXBsZXhpbmcuCj4gPiAKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogU2h1bnN1a2UgTmFrYW11
cmEgPG5ha2FtdXJhLnNodW5AZnVqaXRzdS5jb20+Cj4gPiAtLS0KPiA+wqAgdG9vbHMvbGliL3Bl
cmYvZXZzZWwuYyB8IDYgKysrKysrCj4gPsKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9wZXJmL2V2c2VsLmMgYi90b29scy9s
aWIvcGVyZi9ldnNlbC5jCj4gPiBpbmRleCA4NDQxZTNlMWFhYWMuLjBlYmQxZDM0NDM2ZiAxMDA2
NDQKPiA+IC0tLSBhL3Rvb2xzL2xpYi9wZXJmL2V2c2VsLmMKPiArKysgYi90b29scy9saWIvcGVy
Zi9ldnNlbC5jCj4gPiBAQCAtMTgsNiArMTgsNyBAQAo+ID7CoCAjaW5jbHVkZSA8c3lzL2lvY3Rs
Lmg+Cj4gPsKgICNpbmNsdWRlIDxzeXMvbW1hbi5oPgo+ID7CoCAjaW5jbHVkZSA8YXNtL2J1Zy5o
Pgo+ID4gKyNpbmNsdWRlIDxsaW51eC9tYXRoNjQuaD4KPiA+wqAgCj4gPsKgIHZvaWQgcGVyZl9l
dnNlbF9faW5pdChzdHJ1Y3QgcGVyZl9ldnNlbCAqZXZzZWwsIHN0cnVjdCBwZXJmX2V2ZW50X2F0
dHIgKmF0dHIsCj4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
bnQgaWR4KQo+ID4gQEAgLTMyMSw2ICszMjIsMTEgQEAgaW50IHBlcmZfZXZzZWxfX3JlYWQoc3Ry
dWN0IHBlcmZfZXZzZWwgKmV2c2VsLCBpbnQgY3B1LCBpbnQgdGhyZWFkLAo+ID7CoMKgwqDCoMKg
wqDCoCBpZiAocmVhZG4oKmZkLCBjb3VudC0+dmFsdWVzLCBzaXplKSA8PSAwKQo+ID7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1lcnJubzsKPiA+wqAgCj4gPiArwqDCoMKg
wqAgaWYgKGNvdW50LT5lbmEgIT0gY291bnQtPnJ1bikgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoY291bnQtPnJ1biAhPSAwKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY291bnQtPnZhbCA9IG11bF91NjRfdTY0X2RpdjY0KGNvdW50LT52
YWwsIGNvdW50LT5lbmEsIGNvdW50LT5ydW4pOwo+ID4gK8KgwqDCoMKgIH0KPiAKPiBzbyBJIHRo
aW5rIHBlcmYgc3RhdCBleHBlY3QgcmF3IHZhbHVlcyBpbiB0aGVyZSBhbmQgZG9lcyB0aGUKPiBz
Y2FsaW5nIGJ5IGl0c2VsZiwgcGxlYXNlIGNoZWNrIGZvbGxvd2luZyBjb2RlOgo+IAo+IHJlYWRf
Y291bnRlcnMKPiDCoCByZWFkX2FmZmluaXR5X2NvdW50ZXJzCj4gwqDCoMKgIHJlYWRfY291bnRl
cl9jcHUKPiDCoMKgwqDCoMKgIHJlYWRfc2luZ2xlX2NvdW50ZXIKPiDCoMKgwqDCoMKgwqDCoCBl
dnNlbF9fcmVhZF9jb3VudGVyCj4gCj4gwqAgcGVyZl9zdGF0X3Byb2Nlc3NfY291bnRlcgo+IMKg
wqDCoCBwcm9jZXNzX2NvdW50ZXJfbWFwcwo+IMKgwqDCoMKgwqAgcHJvY2Vzc19jb3VudGVyX3Zh
bHVlcwo+IMKgwqDCoMKgwqDCoMKgIHBlcmZfY291bnRzX3ZhbHVlc19fc2NhbGUKPiAKPiAKPiBw
ZXJoYXBzIHdlIGNvdWxkIGV4cG9ydCBwZXJmX2NvdW50c192YWx1ZXNfX3NjYWxlIGlmIGl0J2Qg
YmUgYW55IGhlbHAKClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50LgoKVGhlIHB1cnBvc2Ugb2Yg
dGhpcyBwYXRjaCBpcyB0byB1bmlmeSB0aGUgY291bnRlcnMgb2J0YWluZWQgd2l0aCAKcGVyZl9l
dnNlbF9fcmVhZCgpIHRvIHNjYWxlZCBvciB1bnNjYWxlZCB2YWx1ZXMuCgpwZXJmX2V2c2VsX19y
ZWFkKCkgZ2V0cyBjb3VudGVyIGJ5IHBlcmZfbW1hcF9fcmVhZF9zZWxmKCkgaWYgUkRQTUMgaXMg
CmF2YWlsYWJsZSwgZWxzZSBnZXRzIGJ5IHJlYWRuKCkuIEluIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24sIGNhbGxlciAKZ2V0cyBzY2FsZWQgY291bnRlciBpZiBnb2VzIHRocm91Z2ggUkRQTUMgcGF0
aCwgb3RoZXJ3aXNlIGdldHMgdW5zY2FsZWQgCmNvdW50ZXIgdmlhIHJlYWRuKCkgcGF0aC4KCkhv
d2V2ZXIgY2FsbGVyIGNhbm5ub3Qga25vdyB3aGljaCBwYXRoIHdlcmUgdGFrZW4uCgpJZiBjYWxs
ZXIgZXhwZWN0cyBhIHJhdyB2YWx1ZSwgSSB0aGluayB0aGUgUkRQTUMgcGF0aCBzaG91bGQgYWxz
byAKcmV0dXJuIGFuIHVuc2NhbGVkIGNvdW50ZXIuCgpkaWZmIC0tZ2l0IGEvdG9vbHMvbGliL3Bl
cmYvbW1hcC5jIGIvdG9vbHMvbGliL3BlcmYvbW1hcC5jCmluZGV4IGM4OWRmYTUuLmFhYTQ1Nzkg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL2xpYi9wZXJmL21tYXAuYworKysgYi90b29scy9saWIvcGVyZi9t
bWFwLmMKQEAgLTM1Myw4ICszNTMsNiBAQCBpbnQgcGVyZl9tbWFwX19yZWFkX3NlbGYoc3RydWN0
IHBlcmZfbW1hcCAqbWFwLCBzdHJ1Y3QgcGVyZl9jb3VudHNfdmFsdWVzICpjb3VudAogICAgICAg
ICAgICAgICAgY291bnQtPmVuYSArPSBkZWx0YTsKICAgICAgICAgICAgICAgIGlmIChpZHgpCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNvdW50LT5ydW4gKz0gZGVsdGE7Ci0KLSAgICAgICAgICAg
ICAgIGNudCA9IG11bF91NjRfdTY0X2RpdjY0KGNudCwgY291bnQtPmVuYSwgY291bnQtPnJ1bik7
CiAgICAgICAgfQoKICAgICAgICBjb3VudC0+dmFsID0gY250OwoKUm9iLCBkbyB5b3UgaGF2ZSBh
bnkgY29tbWVudHM/CgpCZXN0IFJlZ2FyZHMKU2h1bnN1a2U=
