Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B08C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Mar 2022 01:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiCIBQv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiCIBQn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Mar 2022 20:16:43 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236B200565
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Mar 2022 17:05:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPjwCOpQuYDbi8a/Mz1ciVAx4RVp/GyRIi7SV1b1T4+D0Kls7ux+fJbbn5e/Hf70yj9sYtGPcdCnH3eGnCVeusRRS2PxZoh4zyR9JxC/jJmKC7pyJftL4fPpUvKDUCsyyu4+Wc30kGSHH7O/AycJrF0z36IkAFhWu1wJjAJtLUxmxH2/G75PTrQWJG/goKD5yCzzGGXLuWFi65c7e/Mwjx9iYG0WDsu7Nvns0BAoSwiZZdxCLW9XAFf8x4bJf7WkPGP2Z9OriVceMnNUivKkY+8iZEZeMMWTgJlurHQ4pne6HIyMx+i8NrfRBoaBWnAWaC0WASUUaQXSVgenbUk7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kfu2Gar9NqgiBz03JnKMST2VDcKlsrX7tapnZpm9ZFM=;
 b=bydRxSsWCF7GcQZukUcaLdszk6x7JKxDKE1bT5LvFYl3ng723y+PJXH9Kv4Vsfw26sHCbumfI5VYUtHh4ZTyGiX8wskgr0KeBF12RqzzJV3gQRNtIYhx8yniqoC1xIuD8zp0uByPJGeo9qsTB7Z79PL0qRZR6Dqe+7ubfA9WPmgzpiGt7BJizsMg486aseD4gw1HD8l5lAgv9xHnkFQ1BvFv77DSirtq46bEyJLhQ7ZgiR1nMUWeiCtprmlzwFUDka0BGiUbkKJMbHcNhzAyxLwTYVkSBVLaCISq8lX51BiJMJRyRMLkfd2QIzIJZfcanetd4TaBjIMN1aGMMjsBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfu2Gar9NqgiBz03JnKMST2VDcKlsrX7tapnZpm9ZFM=;
 b=h9QHbLkgDV/UCUiHz92g2Lh0X13OaIDQK8jeGOcRc04fYrrSAur17XiIW/Dt4FhfU7YUO7rQHCcV/6567fdQkOQQawW4lOy6KsDYmfMWOL0WYOHwHfmXgKwydy+0Z/djI2f9ZYHhHUvmeAU/mWz+SsyKQpF6KBDIfLjw9NQL+zc=
Received: from DM5PR15MB1739.namprd15.prod.outlook.com (2603:10b6:4:5b::22) by
 BN6PR15MB1492.namprd15.prod.outlook.com (2603:10b6:404:c7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 01:05:34 +0000
Received: from DM5PR15MB1739.namprd15.prod.outlook.com
 ([fe80::ddea:a32d:ffab:70f8]) by DM5PR15MB1739.namprd15.prod.outlook.com
 ([fe80::ddea:a32d:ffab:70f8%11]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 01:05:33 +0000
From:   Douglas Graham <douglas.graham@ericsson.com>
To:     James Clark <james.clark@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: What exactly does -F <freq> do?
Thread-Topic: What exactly does -F <freq> do?
Thread-Index: AdgwKW7BTGI98hwwTTKcL/QVTcLgmACve3YAABU6MIA=
Date:   Wed, 9 Mar 2022 01:05:33 +0000
Message-ID: <DM5PR15MB1739AC36558E0ED388735AB6F00A9@DM5PR15MB1739.namprd15.prod.outlook.com>
References: <DM5PR15MB17390661547DEAA8C397A540F0069@DM5PR15MB1739.namprd15.prod.outlook.com>
 <9b4749a8-f3f3-e2e6-b1d3-8b23d946e10a@arm.com>
In-Reply-To: <9b4749a8-f3f3-e2e6-b1d3-8b23d946e10a@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a88022fb-07e9-43ae-9df1-08da0168e9e1
x-ms-traffictypediagnostic: BN6PR15MB1492:EE_
x-microsoft-antispam-prvs: <BN6PR15MB14928E4369725C3A2DA65EDEF00A9@BN6PR15MB1492.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TY1RfVM/+w2bi6oI/o5tKY/priJM0mmOStIN3uKfWIDpQghda+qXocknvEUeMFQhixFlLrsRsBump7kG1a5uwRK+D4C1nGUNv3Mxl+D1M8HOFTU1voqAfwSvSRTnKjDI2Ar2NBvt2hHsDEYyb2xMuzdHOirsNZNHrIdlbO247bbxSNF81/1IXFE2yEcLNgGEeLORXpWaWAO+ARCJBjo12JmuGdCSDLM5mu1pN3re/czDMQ5zGrtVwzWyDGSoLIKd7JgpZhYi5eisRparSh1ZTOUEG2BcHVCfRDJQuDMaN3+Aa2i/kSCZZZ6Na7HzhSQ1I55L7FJjpkJcNwaPkh+xaCZqFbwrokZ3utZcjjeBN4bfGOXpaiUVmilbLMFrYWdnhHJhGndl5rN7aw1DniPZnS8eTQXPsyaPhM5H4OndGgBma9SI6nm4y0g+4hnQrRxx5GsTtTxvWFjn43K+ZLty3OpHrUGQF2wL3PCxgLNTtIlMenzGXviNuePeBhtj8nMRdNtAdhUyoc8/n7ACD5C/S0Ustl1BgyARogFGMKAkQONNyPpOUhvVTfsHW7X7OW/7QPz+ov+EH7G83i9jPGY3YOjFfBpQSM/WCrRCa0+w3QXRQ62yu7WM/sWTbiUEgZpqVg+bmOKz+kgpoac7vMh5BBwRAThn1Z7uKDIE19gvL+nrDCBVy588IbSQz0JcHPVV80Oi0wf5rvtxSuXxyHAAbZGurVKjkTMdLTll7isBok0RcawqznF78XLR5dGXHhgtIFBvA+X3yjBmKCpXn6lMBFxJ5UG/qCdf/vUDPorvHMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR15MB1739.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(26005)(122000001)(52536014)(8936002)(5660300002)(316002)(33656002)(38070700005)(2906002)(71200400001)(6506007)(7696005)(44832011)(110136005)(9686003)(55016003)(508600001)(83380400001)(966005)(82960400001)(66446008)(64756008)(8676002)(76116006)(66476007)(66556008)(66946007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGdDcFIrK25zMTdyV29IazJTZXllMVFkMCs4QVdTUEVMclIwc0p5YlF5OWxW?=
 =?utf-8?B?K0FFckQwT0dveXlCN214WEsyWHpjazFJay9ZNkZLWWplUk5QNGc0UHhwYWho?=
 =?utf-8?B?TjFXWklrMWE2Z0pXVm1lR2VhV3JDMUlyL3E1L1R2ZTFselpWNnJoZnJ3QkMr?=
 =?utf-8?B?VUo1N09RcHZ5TGhBaXYxalZTRGgxazd5K1pKMmx5ZXIyY3RoSTJhayt5NXBO?=
 =?utf-8?B?UXMyN2kvWU8rYmtMNmw4Qy9Yakl1OWNxZ3dhQUVETkV6N2Z5RGxENElvRDR3?=
 =?utf-8?B?eExKckduU3VVVGlBakVhZ2pQd1VjSTNlR292ZWZxeU83cGVDTk5SOGVYTDJm?=
 =?utf-8?B?RkhJVWUxTjRVeFdVR2YzWktKMnR3eDgvcmMyVFpRSjRBS1pXVTF3cmErc3ZO?=
 =?utf-8?B?Mi9KRXlrUEhDR3R4NzN2TXdhTHhvYTV6b1VYb2VlQzZiQ1dQYldLdVI3VGhk?=
 =?utf-8?B?WGpiWVFxVGpGNzNJYndNeGdDZ3lEV3E2aGMxNTc3NVFVbHdHVHR4SnVQUzM5?=
 =?utf-8?B?UTVXNzJ4cHNPZTFpUjJEZVh6ZGFIMlRzZEsrMFJkM002SDYwNjhLRW1SQnJh?=
 =?utf-8?B?c3IrcnErVFZvZlVhVXgrU1dOUkhWeHhuRGpmdUN3eFVvUkpyUDFZSTZKa1BV?=
 =?utf-8?B?ZUNwK2VoN1pLanpNSHR1em5UVVorQmNDZnIrNzl6K2ptL1UyTk5nY05iWFVa?=
 =?utf-8?B?eWZIQUcrQ2xiaHY5QTNtMEJ2VlpQNlFlRVlKNGVlTDZZeWI0NGh0UW9MZm94?=
 =?utf-8?B?THh5UklpRjFiTEJzYTFReGtOVmlvZzlNSENNYmRBM1IycnBrMEpuVm8xWXdu?=
 =?utf-8?B?Tzh4MmE5TTk2RWZsekI2ditoN0d4MVF2VzkzMDM1cWNNZWhkR2hjM2gyRUdW?=
 =?utf-8?B?NEZIRFRmdmNLcTBSRlJ2cEMyU2ZMbXRZRFVCNnJ6Q21ZeG04MWZ3Z05kSjdW?=
 =?utf-8?B?bXdNL0V3TGtGTFpPZ0ViZ0NxUWo5byt6bXdtM2N0ZllaeVhVVmVzOXhnaWFJ?=
 =?utf-8?B?em9Xci9jNkduSDZQM1o5ckxFVGlhakkrM280SzRtKzdlRG9OQnNqdGpGeXBE?=
 =?utf-8?B?MXBlWThhQVhkVzlJbmpteCtWRHZ0V2Fscy9WU0RKRWQ2NGxSWmxxSDF3b3JN?=
 =?utf-8?B?ZzFNZVVKR0oweFRRdEJudHJUYVBBNlBuOURXaEVmWXkyOVI1WTdqM0JSN0tW?=
 =?utf-8?B?QkEvMUFBcjh0dTdMRHBGNHJ1M21JUFNrQXpZUzhlcmpoYVUzUW5XOGJqNzZh?=
 =?utf-8?B?cFd5bXZ5bXIyVFNlWW5icERMTHA5OFVBRGNsL1BPdlFtc2lSd3JnS1hiMU5J?=
 =?utf-8?B?UkJvenFrMlVhdzlzUlFtbWFrYVdKR3owenhzd0NPT3pOSklpSGhvQVhmNDdK?=
 =?utf-8?B?ZjJjUmtBRnZTUUN5bC90M0lSN1AybEtDVUY3cXdtWEZrNGd3dDllMUpzNTJS?=
 =?utf-8?B?bFFjdWNPYkZWalhOSEo3aWQ4TFJLWkdVTnhTRVUzZmh2aHdmU0tPZFNCdHMv?=
 =?utf-8?B?Z2hFSEJ5ME85bytBTGcxRXkyYi8vL2dsTDJFYXVleFlHalIyOEFTSHd2bmtO?=
 =?utf-8?B?S0NUWHlRV3FhY3NSSFNpZkNZUU5Cd3c2VStjZTZiV0lXYlZOL0VDck8rRFg1?=
 =?utf-8?B?MzVhbElHcFhFT3R1MmxlZDkzY3gxQXlNajVEQ2R6ejBvVE10RGJ4bldiaEZL?=
 =?utf-8?B?aDVobkt5VEVicjdyK2FYbnZlTktWVVp4aVRESWtEaU10dkVjRUlocGM3ZlN6?=
 =?utf-8?B?N1B0eUxyWlBWYXI5aUd0TGcvbFJ5LzFLenJXMWF2THZyWC9vOWh1UGpFcnpT?=
 =?utf-8?B?NXR5N1VnSm8ybTdiTWpoUEU3ajl4b1plcmRkUlpLS3RYVVM1eGp1dVByUXBs?=
 =?utf-8?B?MlRpMGpscjVEVTVGMG5PTWo0YVJ0NjRBYnl5ZTdKK2RXTUl3blJ5OVNGcWpP?=
 =?utf-8?B?aGR0RjJCKy91U1VxSXN1YldmU3YrSDBHclQ1OUhCSENkN3Rtamkra2UyQkRE?=
 =?utf-8?B?WXdLdit0aW1PdmZQZllDUXoyMVlYOHJidU91TnVaOVg5UXRJY2NaSlFUSjh2?=
 =?utf-8?B?cDJrekdmY2lRbFhjNEhuNXpURkJjcCs5OFJwQnIybkgzTWxjSFBXM1VOV00w?=
 =?utf-8?B?RndpVTQvcjNlRXZsQ1pUV3RpUExWSUdVam9YTGZ3KzJMZjRnRXlxWjBUYzNp?=
 =?utf-8?B?Um5BaFk5Sis3OUppUll0QzlsMnd4NHVaZ1BuMEN2cUhZMXlIQmVjN0hnOGdm?=
 =?utf-8?B?Y3FjLzB3WkVKdUM2S3c4b1poblFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR15MB1739.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88022fb-07e9-43ae-9df1-08da0168e9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 01:05:33.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypqAP61D7ibTj71cX0bWmuwlq94GwZA1WtZVwndCuuXiKatXoTf/lqCN2yYh6RUziYxc3Nt2QvYr2ddpybln8+Shy7ZZYbqYHFtZ7c3CXrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1492
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmVwbHkuDQoNCiA+IFllcyB5b3UgYXJlIHJpZ2h0LCBwZXJmIG9ubHkg
cmVjb3JkcyB3aGVuIHRoZSBwcm9jZXNzIGlzIHNjaGVkdWxlZCBvbg0KPiB0aGUgQ1BVLiBJZiB5
b3UncmUgY291bnRpbmcgY3ljbGVzIGFuZCB0aGF0IHByb2Nlc3MgaXNuJ3Qgc2NoZWR1bGVkDQo+
IHRoZW4gY3ljbGVzIGlzbid0IGluY3JlYXNpbmcgc28geW91IHdpbGwgZ2V0IG5vIHNhbXBsZXMu
DQoNCk1heWJlIHRoZXJlIGlzIHNvbWV0aGluZyBmdW5kYW1lbnRhbCBhYm91dCBob3cgcGVyZiBy
ZWNvcmQgd29ya3MgdGhhdCBJJ20gbm90IGdldHRpbmcuDQpJJ20gYXNzdW1pbmcgdGhhdCBjeWNs
ZXMgaXMgYWx3YXlzIGluY3JlbWVudGluZywgcmVnYXJkbGVzcyBvZiB3aGF0IGlzIGhhcHBlbmlu
ZyBpbg0Kc29mdHdhcmUgb3Igd2hhdCB0aHJlYWQgaXMgcnVubmluZy4gVGhlIG9ubHkgdGhpbmcg
dGhhdCBtaWdodCBjaGFuZ2UgaXRzIGZyZXF1ZW5jeSBpcw0KQ1BVIGZyZXF1ZW5jeSBzY2FsaW5n
LiBXaXRob3V0IGZyZXFlbmN5IHNjYWxpbmcsIGN5Y2xlcyBpcyBpbmNyZW1lbnRlZCBhdCBhIGNv
bnN0YW50IHJhdGUuICBJIGFzc3VtZQ0KdGhlIHdheSBpdCB3b3JrcyB3aGVuIEkgdXNlIC1jIDxz
YW1wbGUgcGVyaW9kPiBpcyB0aGF0IGl0IHdyaXRlcyB0aGUgc3BlY2lmaWVkIHNhbXBsZSBwZXJp
b2QgdG8gYQ0KUE1VIHJlZ2lzdGVyLiBXaGVuIHRoZSBudW1iZXIgb2YgZWxhcHNlZCBjeWNsZXMg
aGl0cyB0aGF0IGxpbWl0LCBhbiBpbnRlcnJ1cHQgaXMgZ2VuZXJhdGVkLg0KVGhlIElTUiBleGFt
aW5lcyB0aGUgc3RhdGUgb2YgdGhlIENQVS4gIElmIGl0IGlzIGlkbGUsIHRoZW4gbm8gc2FtcGxl
IGlzIHNhdmVkLiBJZiBhIHRocmVhZA0KaXMgcnVubmluZywgaXRzIHByb2dyYW0gY291bnRlciAo
YW5kIHBvc3NpYmx5IGEgd2hvbGUgYmFja3RyYWNlKSBpcyBzYXZlZC4gIFNvIGlmIHRoZSBDUFUN
CmlzIDEwJSBidXN5LCBvbmx5IDEwJSBvZiB0aGUgc2FtcGxpbmcgaW50ZXJydXB0cyB3aWxsIGFj
dHVhbGx5IHdpbmQgdXAgc2F2aW5nIGEgc2FtcGxlLg0KDQpZb3Ugc2VlbSB0byBiZSBzYXlpbmcg
dGhhdCB0aGUgc2FtcGxpbmcgaW50ZXJydXB0cyBhcmUgb25seSBnZW5lcmF0ZWQgd2hlbiBhIHRo
cmVhZCBpcyBydW5uaW5nDQphbmQgdGhhdCB0aGV5IGFsbCByZXN1bHQgaW4gYSBzYW1wbGUgYmVp
bmcgc2F2ZWQuIEkgdGhpbmsgdGhpcyBtYWtlIHNlbnNlIHdoZW4gdGhlIGV2ZW50IGJlaW5nDQpt
b25pdG9yZWQgaXMgY2F1c2VkIGJ5IHNvbWV0aGluZyB0aGUgdGhyZWFkIGRvZXMuICBGb3IgZXhh
bXBsZSwgeW91IHdvbid0IGdldCBhbnkgY2FjaGUNCm1pc3NlcyBpZiBub3RoaW5nIGlzIHJ1bm5p
bmcsIHNvIGlmIHlvdXIgZXZlbnQgaXMgY2FjaGUgbWlzc2VzLCB5b3Ugd2lsbCBuZXZlciBnZXQg
YSBzYW1wbGluZyBpbnRlcnJ1cHQNCndoaWxlIHRoZSBDUFUgaXMgaWRsZS4gICBCdXQgdW5sZXNz
IEknbSBtaXNzaW5nIHNvbWV0aGluZywgY3ljbGVzIGluY3JlbWVudHMgcmVnYXJkbGVzcyBvZiB3
aGF0DQp0aGUgc29mdHdhcmUgaXMgZG9pbmcsIHNvIHlvdSBnZXQgdGhvc2UgaW50ZXJydXB0cyBu
byBtYXR0ZXIgd2hhdCBpcyBoYXBwZW5pbmcgaW4gc29mdHdhcmUuDQoNCklmIEknbSByaWdodCBh
Ym91dCBjeWNsZXMgaW5jcmVtZW50aW5nIGF0IGEgZml4ZWQgcmF0ZSwgdGhlbiB0aGUgLWMgPHNh
bXBsZV9wZXJpb2Q+IG9wdGlvbiB3aWxsIHJlc3VsdA0KaW4gYSBzYW1wbGluZyBpbnRlcnJ1cHQg
YXQgYSBmaXhlZCBmcmVxdWVuY3kuICBJZiB0aGUgY2xvY2sgcmF0ZSBpcyBrbm93biwgdGhlbiBj
b252ZXJ0aW5nIHNhbXBsZV9wZXJpb2QNCnRvIHNhbXBsZSBmcmVxdWVuY3kgYW5kIHZpY2UgdmVy
c2Egc2hvdWxkIGJlIHNpbXBsZS4gIEFuZCB5ZXQsIC1GIDxmcmVxPiBzZWVtcyB0byBkbyBzb21l
dGhpbmcgcXVpdGUNCmRpZmZlcmVudCB0aGFuIC1jIDxzYW1wbGVfcGVyaW9kPi4NCg0KPiBJZiB5
b3UgaGF2ZSBhIHByb2Nlc3MgdGhhdCBoYXMgYSBsb3Qgb2YgaWRsZSB0aW1lIHRoZW4gbWF5YmUg
LWMNCj4gaXMgYmV0dGVyIHRoYW4gLUYuIEl0IGFsc28gc291bmRzIGxpa2UgeW91IGFyZSBsb29r
aW5nIGZvciBhIHdhbGwNCj4gY2xvY2sgdGltZSBwcm9maWxlciB3aGljaCBwZXJmIGlzbid0Lg0K
DQpJIGFtIHByb2ZpbGluZyBhIG11bHRpdGhyZWFkZWQgYXBwbGljYXRpb24gcnVubmluZyBvbiBh
IHF1YWQgY29yZSBwcm9jZXNzb3IuIEkgbWFpbmx5IGp1c3Qgd2FudCB0bw0KbWFrZSBzdXJlIEkg
dW5kZXJzdGFuZCB3aGF0IHBlcmYgaXMgYWN0dWFsbHkgZG9pbmcgc28gSSBrbm93IGhvdyB0byBp
bnRlcnByZXQgdGhlIHJlc3VsdHMuIEkga25vdyB3aGF0DQp0aGUgcmVzdWx0cyBmcm9tIGEgZml4
ZWQgc2FtcGxpbmcgcGVyaW9kIG1lYW4sIGJ1dCBJJ20gaGF2aW5nIGEgaGFyZCB0aW1lIHdyYXBw
aW5nIG15IGhlYWQgYXJvdW5kDQp3aGF0IHRoZSByZXN1bHRzIGZyb20gLUYgbWVhbi4gVGhpcyBn
dXk6IGh0dHA6Ly9zYW5kc29mdHdhcmVzb3VuZC5uZXQvcGVyZi9wZXJmLXR1dC1wcm9maWxlLWh3
LWV2ZW50cw0Kc2VlbXMgdG8gaGF2ZSBjb21lIHRvIHRoZSBzYW1lIGNvbmNsdXNpb24uDQoNCkkg
YW0gYWxyZWFkeSB1c2luZyAtYS4NCg0KU2luY2UgbW9zdCBvciBhbGwgb2YgdGhpcyBkaXNjdXNz
aW9uIHNlZW1zIHRvIGhpbmdlIG9uIHdoYXQgaGFwcGVucyB3aGVuIGEgY29yZSBpcyBpZGxlLCB0
aGlzDQpodHRwczovL3d3dy5icmVuZGFuZ3JlZ2cuY29tL3BlcmYuaHRtbCNGbGFtZUdyYXBocyBt
aWdodCBiZSByZWxldmFudC4gIEl0IGNvbnRhaW5zIHNvbWUNCm1lbnRpb24gb2YgZmlsdGVyaW5n
IG91dCBjcHVfaWRsZSBzYW1wbGVzOg0KDQogICAgSSBmcmVxdWVudGx5IGVsaWRlIHRoZSBjcHVf
aWRsZSB0aHJlYWRzIGluIHRoaXMgd2F5LCB0byBmb2N1cyBvbiB0aGUgcmVhbCB0aHJlYWRzIHRo
YXQgYXJlIGNvbnN1bWluZyBDUFUgcmVzb3VyY2VzDQogICAgSWYgSSBtaXNzIHRoaXMgc3RlcCwg
dGhlIGNwdV9pZGxlIHRocmVhZHMgY2FuIG9mdGVuIGRvbWluYXRlIHRoZSBmbGFtZSBncmFwaCwg
c3F1ZWV6aW5nIHRoZSBpbnRlcmVzdGluZyBjb2RlIHBhdGhzLg0KDQpJIGRvbid0IHNlZSBhIGxv
dCBvZiBjcHVfaWRsZSBzYW1wbGVzIHNvIG1heWJlIHRoaXMgaXMgb2Jzb2xldGUgYnV0IGl0IGRv
ZXMgaW1wbHkgdGhhdCBwZXJmIHJlY29yZCAtRiBkaWQgYXQgb25lIHRpbWUNCmdlbmVyYXRlIGxv
dHMgb2YgaWRsZSBzYW1wbGVzLg0KDQpSZWdhcmRzLA0KRG91Zw0K
