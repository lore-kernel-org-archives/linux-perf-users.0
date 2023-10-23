Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301D63A8
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Oct 2023 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FTO2RWnj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FTO2RWnj"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2072.outbound.protection.outlook.com [40.107.103.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C890598
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Oct 2023 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUas6pVEASk7ufAkbN8NB4SUJVuwo/OHM4ncaKYJMIM=;
 b=FTO2RWnjkAYxOvnWjbnu2OMUdIhEqrEO6Bjs/O/161JtONUtH/PmeOV2wjjFdcGZknnJVH4iQusc2Dk3FiYnvUcKRhIqPKFJgZqY/RnWNID+7RUbi2Goo1ADgqVjtFnatLROzn9hpG4An1YxZS7QFEXa6tYgDL217Y31IrWDfKY=
Received: from DB7PR05CA0071.eurprd05.prod.outlook.com (2603:10a6:10:2e::48)
 by DB9PR08MB8412.eurprd08.prod.outlook.com (2603:10a6:10:3d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 09:04:59 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:2e:cafe::4a) by DB7PR05CA0071.outlook.office365.com
 (2603:10a6:10:2e::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 09:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 09:04:59 +0000
Received: ("Tessian outbound d9a8e74be042:v215"); Mon, 23 Oct 2023 09:04:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 368a592b10c55aaa
X-CR-MTA-TID: 64aa7808
Received: from e48af4207413.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id F5195BF7-EE29-46D2-8379-0F3C2DDFFED8.1;
	Mon, 23 Oct 2023 09:04:52 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e48af4207413.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Oct 2023 09:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTpfNuyXJatGQEy/mS/onSfmQTo43kEL4wx9wDNDT5czY8dpDucwQAJKaThmqDCwITS1i+Cp89FrME5BRkUKsTEjOv7HeSxo8mU5H57asUSEUIZvEvUOBqWMo0i1VbBpi+/SGI2KgsIJDIdmqNj7ZPzTifGUSVQ1urqdfTNesBAlHahVAf9j7GD08Go792bTODS2cTZcEPJn6cuohvv3hi3FZeMkqjYRfflcAiXjo10l12gUZLlu0W/JYMHTJUDqIEpdGJtOXXWKjh6buxF293zuKTkzCA2XXgq0I5sY6R/9p3rEmcq/6tUDIGfp5kC+XiDlf4hN1JtLlDCazAfHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUas6pVEASk7ufAkbN8NB4SUJVuwo/OHM4ncaKYJMIM=;
 b=dM2rVtV91D0A6+Al0u8y5nkcNkJufFCC2VSR4h8Fib2igexR5cxR6CodMC/Xaox9NXW21meH8EBGEWGaJyh1qmkRUKR7YAMrIPR1KyRnovjO3nhRtHpvopEo9jpAUZYmO/Jk9CqrtOktUtyPaLV1707jIwRle1MYhsrfX2r+ALsA0HA1HR59ZwacD0RHw24/dcVeX4azII0/T6ZEWfOF3GAjp3u7zgJ0hZaRVmO7J/+D19TAbj/6sfaqEFfQjPx5Aed6XYwwZvNhNmAukH3RELaUPT7+s5utfoqKBGoer3HB1d5N8aQlwo5cmrJRB3xdGjAXt+zj0VZqTvLj9gErbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUas6pVEASk7ufAkbN8NB4SUJVuwo/OHM4ncaKYJMIM=;
 b=FTO2RWnjkAYxOvnWjbnu2OMUdIhEqrEO6Bjs/O/161JtONUtH/PmeOV2wjjFdcGZknnJVH4iQusc2Dk3FiYnvUcKRhIqPKFJgZqY/RnWNID+7RUbi2Goo1ADgqVjtFnatLROzn9hpG4An1YxZS7QFEXa6tYgDL217Y31IrWDfKY=
Received: from DBBPR08MB4313.eurprd08.prod.outlook.com (2603:10a6:10:c9::19)
 by DBAPR08MB5672.eurprd08.prod.outlook.com (2603:10a6:10:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 09:04:49 +0000
Received: from DBBPR08MB4313.eurprd08.prod.outlook.com
 ([fe80::5772:4d1:e626:c2d1]) by DBBPR08MB4313.eurprd08.prod.outlook.com
 ([fe80::5772:4d1:e626:c2d1%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 09:04:49 +0000
From: Carsten Haitzler <Carsten.Haitzler@arm.com>
To: "leo.yan@linaro.org" <leo.yan@linaro.org>, Michael Petlan
	<mpetlan@redhat.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"acme@redhat.com" <acme@redhat.com>, "vmolnaro@redhat.com"
	<vmolnaro@redhat.com>
Subject: Re: [PATCH] perf test: Skip CoreSight tests if cs_etm// event is not
 available
Thread-Topic: [PATCH] perf test: Skip CoreSight tests if cs_etm// event is not
 available
Thread-Index: AQHaAmxPb91HDpxf4E+XtdiCZyZq17BQ4W+AgAY5q4A=
Date: Mon, 23 Oct 2023 09:04:49 +0000
Message-ID: <33aba752-06e0-4457-b0bb-428f94af6ee7@arm.com>
References: <20231019091137.22525-1-mpetlan@redhat.com>
 <20231019100051.GB105208@leoy-huanghe.lan>
In-Reply-To: <20231019100051.GB105208@leoy-huanghe.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DBBPR08MB4313:EE_|DBAPR08MB5672:EE_|DU2PEPF0001E9C5:EE_|DB9PR08MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ef68c7-b340-4080-59cd-08dbd3a72273
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 sBj1jOkT7AQ7XoSwfdFzl9XBTusAr9JmZyw3Atg2l5xnW2ct0X1CccrMjp7lWBkHIT4CHUwHoQmO5yOIrpTDww0ZU6PSbKuN0la+YboJz+rCvPKKH4hoimVmKKaxgxsHv06q0uiVn4sdrQ78v+I9qPOe3eKv7bUx6YAkBJ7+icFSQXTUYokuuGjZcDY8nnSDe9tYSaOPH7OnIBLH4WGOHsXm/yAG2omXhu9C/8qlfD+4lIQEA0ucBMkeIGBSb+iiLOFHRauYfHcNgeYovXTRvfTz3qa6m7DYmv3+jSFnXG46GtuDCSR01E5/jpGRbHJD2prEkhV44kNBH5/m0CVmj1iCnETk+s5gUD7KWAM42m55VelTgjif9Z+hQPouRj5RkU69+O03pkkS0TIlE8oBt6+C5QytIwoPf3yilmTC6iiXbqZRXsBTioZehWLZ8B6rvqPiQqMEZJ/JXvpDIIE5O10hN+b6X5/0xunUC7pDPhp0xjezQAtxKSzu10b+s6FZZRrtVAhxvYekJk6X3waM49c4FsG2aZvI4F4LVqehHqhEy7EQuSB/WMm6NbKQGNowDJTVXdco8e1oR98WaHBm9GYhCwBsE0wAYevjierCTfT8xfF2hJh40z5B4FFMv1AqCqB/MTwJDjdHeTyJlhoXaf/bjkvvtqnF3tsuEibtkcx/0O+xfbeKOzB3slzU/1pN
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4313.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(38070700009)(31686004)(38100700002)(2906002)(41300700001)(86362001)(31696002)(5660300002)(36756003)(8676002)(8936002)(4326008)(6506007)(71200400001)(478600001)(91956017)(110136005)(122000001)(2616005)(66476007)(66946007)(316002)(76116006)(54906003)(64756008)(66446008)(66556008)(83380400001)(6486002)(53546011)(55236004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A16D1E24F20AA4AA3B3672F94B30EEA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5672
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a8d926eb-8fd0-46b5-dc68-08dbd3a71cc4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WNJhgQfffCAI9fzT3I+SRrmA0ZQgpbVrxTVPjOrKEHiqURFWZuZUv5I3NrpouzJp+T0GDzFGrDRugejPRK32R6qBvyarB4FfzMM/2Ieu1DmCwBVVtaV+kDX+5F6gbu7Xs6yOh2+lB5JlbjEH224N9tO+7SHWNJcAw40PKpnBkJLhsXIZEEMK8xS8noofSqXkPeophRH+wX3AyDLY8APSU1rslS4UgPmLjKbjG+6XlB5ghuJRmq2y4deaD7hjA+Igo24PJSsl8uIDSs8RC975Q723238bkQQjZM6O6cEALHqPCOuyOG8R8Op6coms47T1/f61xQ/KywOGNuCkUuOpAq6G0T2bOROjx3dotJCFcTnu/GjOdefgETogYkyvpL3ZUpOjPZPGcohgxVY+qJtkOHR2RdO1fNs0Zbs6j/w3sQqoo5qc4zeQADwnW6+zMaKSPr2E18fDEWg+a5uYF+bp3YLQFK2zXiZTRBlt8YD7dVwHjXlT5hN2Kgc/6JnDvLgL/qHjpQSoMhtCGTCRVhSnqX6fkF85VHikiYDzAlXwstFvbZsDLOwFspPYAnExIQdFXcJIwxbT1gs2dk0yVKgSRuZ4icqh4XHUQ/0git57xyabu9LfQ1f5KcrEki0x53NeDLcRMHxEBDii9a8yJfwK8l2HelaBT4hXatdOxJNoOY2jPAHUKlQWLfBPPdCnIPHLqIR6oA3tJOl04q36udQbHGMQiqzvDtSNMBtCp1U+B2/AUZBc56OxzmKnB1x5HuNcBDkoZc4tImD1HgYXa3ec1Q==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(46966006)(40470700004)(36840700001)(26005)(31686004)(2906002)(41300700001)(40460700003)(86362001)(31696002)(5660300002)(36756003)(36860700001)(8676002)(8936002)(4326008)(6506007)(478600001)(107886003)(110136005)(2616005)(356005)(82740400003)(81166007)(316002)(54906003)(70206006)(70586007)(83380400001)(40480700001)(6486002)(53546011)(336012)(6512007)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:04:59.3885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ef68c7-b340-4080-59cd-08dbd3a72273
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8412

T24gMTAvMTkvMjMgMTE6MDAsIExlbyBZYW4gd3JvdGU6DQo+IE9uIFRodSwgT2N0IDE5LCAyMDIz
IGF0IDExOjExOjM3QU0gKzAyMDAsIE1pY2hhZWwgUGV0bGFuIHdyb3RlOg0KPj4gQ29yZVNpZ2h0
IG1pZ2h0IGJlIG5vdCBhdmFpbGFibGUsIGluIHN1Y2ggY2FzZSwgc2tpcCB0aGUgdGVzdHMuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBQZXRsYW4gPG1wZXRsYW5AcmVkaGF0LmNvbT4N
Cj4+IC0tLQ0KPj4gICB0b29scy9wZXJmL3Rlc3RzL3NoZWxsL2xpYi9jb3Jlc2lnaHQuc2ggfCAy
ICsrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9saWIvY29yZXNpZ2h0LnNoIGIvdG9vbHMvcGVy
Zi90ZXN0cy9zaGVsbC9saWIvY29yZXNpZ2h0LnNoDQo+PiBpbmRleCA2YzNkMzRlYzY0ZDguLjEx
ZWQyYzI1ZWQ5MSAxMDA2NDQNCj4+IC0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvbGliL2Nv
cmVzaWdodC5zaA0KPj4gKysrIGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9saWIvY29yZXNpZ2h0
LnNoDQo+PiBAQCAtMTAsMjAgKzEwLDIyIEBADQo+Pg0KPj4gICAjIHBlcmYgcmVjb3JkIG9wdGlv
bnMgZm9yIHRoZSBwZXJmIHRlc3RzIHRvIHVzZQ0KPj4gICBQRVJGUkVDTUVNPSItbSAsMTZNIg0K
Pj4gICBQRVJGUkVDT1BUPSIkUEVSRlJFQ01FTSAtZSBjc19ldG0vL3UiDQo+Pg0KPj4gICBUT09M
Uz0kKGRpcm5hbWUgJDApDQo+PiAgIERJUj0iJFRPT0xTLyRURVNUIg0KPj4gICBCSU49IiRESVIv
JFRFU1QiDQo+PiAgICMgSWYgdGhlIHRlc3QgdG9vbC9iaW5hcnkgZG9lcyBub3QgZXhpc3QgYW5k
IGlzIGV4ZWN1dGFibGUgdGhlbiBza2lwIHRoZSB0ZXN0DQo+PiAgIGlmICEgdGVzdCAteCAiJEJJ
TiI7IHRoZW4gZXhpdCAyOyBmaQ0KPj4gKyMgSWYgQ29yZVNpZ2h0IGlzIG5vdCBhdmFpbGFibGUs
IHNraXAgdGhlIHRlc3QNCj4+ICtwZXJmIGxpc3QgY3NfZXRtIHwgZ3JlcCAtcSBjc19ldG0gfHwg
ZXhpdCAyDQo+IFJldmlld2VkLWJ5OiBMZW8gWWFuIDxsZW8ueWFuQGxpbmFyby5vcmc+DQoNClJl
dmlld2VkLWJ5OiBDYXJzdGVuIEhhaXR6bGVyIDxjYXJzdGVuLmhhaXR6bGVyQGFybS5jb20+DQoN
Cg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55
IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0
aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
