From: "Pavey, Nicholas" <npavey@akamai.com>
Subject: Detecting cache line sharing with perf / ocperf
Date: Wed, 18 May 2016 15:10:40 +0000
Message-ID: <B99D9D85-737A-408A-990A-BAA6F60CC0DD@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from prod-mail-xrelay08.akamai.com ([96.6.114.112]:31260 "EHLO
	prod-mail-xrelay08.akamai.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753249AbcERPKo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 May 2016 11:10:44 -0400
Received: from prod-mail-xrelay08.akamai.com (localhost.localdomain [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 0CD502000BF
	for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2016 15:10:42 +0000 (GMT)
Received: from prod-mail-relay08.akamai.com (prod-mail-relay08.akamai.com [172.27.22.71])
	by prod-mail-xrelay08.akamai.com (Postfix) with ESMTP id EB396200036
	for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2016 15:10:41 +0000 (GMT)
Received: from email.msg.corp.akamai.com (ustx2ex-cas5.msg.corp.akamai.com [172.27.25.34])
	by prod-mail-relay08.akamai.com (Postfix) with ESMTP id E856698082
	for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2016 15:10:41 +0000 (GMT)
Content-Language: en-US
Content-ID: <C7A6634BCAAC8E409E62C959598B0581@akamai.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

DQoNCknigJltIGhvcGluZyB0byByZWFkIHRoZSBwZXJmb3JtYW5jZSBjb3VudGVycyB0byBkZXRl
Y3QgY2FjaGUgbGluZSBzaGFyaW5nIChib3RoIHRydWUgYW5kIGZhbHNlKS4NCg0KSeKAmXZlIGdv
dCB0aGUgdmVyeSB1c2VmdWwg4oCYb2NwZXJm4oCZIHRvb2wsIHdoaWNoIGdpdmVzIG1lIGEgbXVj
aCB3aWRlciByYW5nZSBvZiBzeW1ib2xpYyBwZXJmb3JtYW5jZSBjb3VudGVyIG9wdGlvbnMuIE15
IHByb2JsZW0gaXMgdGhhdCB0aGUgc3BlY2lmaWMgcHJvZ3JhbW1pbmcgc2VlbXMgdG8gdmFyeSBi
eSBwcm9jZXNzb3IgbWljcm8tYXJjaGl0ZWN0dXJlLg0KDQpUaGUg4oCYb2NwZXJm4oCZIGNvbW1p
dCBpcyA6DQoNCsKgID4gZ2l0IHJldi1wYXJzZSBIRUFEIA0KwqDCoD4gNTliOWUyM2YyNTJlMTAx
MTQ3ZjIyZDhiYTFkZDQ5YmVhZmUzMTliNw0KDQpNeSBwcm9jZXNzb3IgaXMgOiBJbnRlbChSKSBY
ZW9uKFIpIENQVSBFNS0yNjQwIHYzLCBpbiBhIE5VTUEgY29uZmlndXJhdGlvbiB3aXRoIDIgc29j
a2V0cy4NCg0KSeKAmXZlIGxvb2tlZCBhdCB0aGlzIGRvY3VtZW50Og0KDQrCoCBodHRwczovL3Nv
ZnR3YXJlLmludGVsLmNvbS9lbi11cy9hcnRpY2xlcy9hdm9pZGluZy1hbmQtaWRlbnRpZnlpbmct
ZmFsc2Utc2hhcmluZy1hbW9uZy10aHJlYWRzDQoNCklmIEnigJltIGludGVycHJldGluZyB0aGlz
IGNvcnJlY3RseSwgSSBzaG91bGQgYmUgbG9va2luZyBmb3IgdGhlIGZvbGxvd2luZyBwZXJmb3Jt
YW5jZSBjb3VudGVyczoNCg0KwqAgTUVNX1VOQ09SRV9SRVRJUkVELk9USEVSX0NPUkVfTDJfSElU
TQ0KDQpNYXliZSBJ4oCZbSBtaXNzaW5nIGl0LCBidXQgSSB3YXNu4oCZdCBhYmxlIHRvIGxvY2F0
ZSBhbiBlcXVpdmFsZW50bHkgbmFtZWQgY291bnRlciBpbiDigJhvY3BlcmbigJkuDQoNCknigJl2
ZSBleHBlcmltZW50ZWQgd2l0aCBhIHJhbmdlIG9mIGNvdW50ZXJzIHRvIGRvIHdpdGggc25vb3Bp
bmcgYW5kIE1FU0kgcHJvdG9jb2wgc3RhdGVzLCBidXQgSSBoYXZlbuKAmXQgZm91bmQgYSBwcm9n
cmFtbWluZyB0aGF0IHNlZW1zIHRvIHdvcmsuDQoNCkRvZXMgYW55b25lIGtub3cgdGhlIGNvcnJl
Y3QgcHJvZ3JhbW1pbmcgZm9yIG15IG1hY2hpbmU/DQoNClRoYW5rcywNCg0KDQpOaWNrDQoNCg0K
DQo=
