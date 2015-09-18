From: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?=
	<masami.hiramatsu.pt@hitachi.com>
Subject: RE: [PATCH perf/core ] [BUGFIX] perf probe: Fix a segfault when
 removing uprobe events
Date: Fri, 18 Sep 2015 01:39:13 +0000
Message-ID: <50399556C9727B4D88A595C8584AAB3752541831@GSjpTKYDCembx32.service.hitachi.net>
References: <20150916125241.4446.44805.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:34684 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbIRBjR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 17 Sep 2015 21:39:17 -0400
In-Reply-To: <20150916125241.4446.44805.stgit@localhost.localdomain>
Content-Language: ja-JP
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Milian Wolff <milian.wolff@kdab.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>

SGkgQXJuYWxkbywNCg0KQ291bGQgeW91IHB1bGwgdGhpcyBidWdmaXggYXMgYW4gdXJnZW50IHBh
dGNoLCBzaW5jZSB0aGlzIGZpeGVzIGEgY3JpdGljYWwNCnByb2JsZW0/DQoNClRoYW5rcywNCg0K
RnJvbTogTWFzYW1pIEhpcmFtYXRzdSBbbWFpbHRvOm1hc2FtaS5oaXJhbWF0c3UucHRAaGl0YWNo
aS5jb21dDQo+DQo+Rml4IGEgc2VnZmF1bHQgYnVnIGFuZCBhIHNtYWxsIG1pc3Rha2UgaW4gcGVy
ZiBwcm9iZSAtZC4NCj4NCj5TaW5jZSB0aGUgInVsaXN0IiBpbiBwZXJmX2RlbF9wcm9iZV9ldmVu
dHMgaXMgbmV2ZXIgaW5pdGlhbGl6ZWQsDQo+c3RybGlzdF9fYWRkKHVsaXN0LCAqKSBhbHdheXMg
Y2F1c2VzIGEgc2VnZmF1bHQgd2hlbiByZW1vdmluZw0KPnVwcm9iZSBldmVudHMgYnkgcGVyZiBw
cm9iZSAtZC4NCj4NCj5BbHNvLCB0aGUgInN0ciIgbG9jYWwgdmFyaWFibGUgaXMgbmV2ZXIgcmVs
ZWFzZWQgaWYgZmFpbCB0bw0KPmFsbG9jYXRlIHRoZSAia2xpc3QiLiBUaGlzIGZpeGVzIGl0IHRv
by4NCj4NCj5UaGlzIGhhcyBiZWVuIGludHJvZHVjZWQgYnkgdGhlIGNvbW1pdCBlNjA3ZjE0MjZi
NTggKCJwZXJmIHByb2JlOg0KPlByaW50IGRlbGV0ZWQgZXZlbnRzIGluIGNtZF9wcm9iZSgpIiku
DQo+DQo+UmVwb3J0ZWQtYnk6IE1pbGlhbiBXb2xmZiA8bWlsaWFuLndvbGZmQGtkYWIuY29tPg0K
PlNpZ25lZC1vZmYtYnk6IE1hc2FtaSBIaXJhbWF0c3UgPG1hc2FtaS5oaXJhbWF0c3UucHRAaGl0
YWNoaS5jb20+DQo+LS0tDQo+IHRvb2xzL3BlcmYvYnVpbHRpbi1wcm9iZS5jIHwgICAgNyArKysr
Ky0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
DQo+ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvYnVpbHRpbi1wcm9iZS5jIGIvdG9vbHMvcGVyZi9i
dWlsdGluLXByb2JlLmMNCj5pbmRleCA5NDM4NWVlLi5mNzg4MmFlIDEwMDY0NA0KPi0tLSBhL3Rv
b2xzL3BlcmYvYnVpbHRpbi1wcm9iZS5jDQo+KysrIGIvdG9vbHMvcGVyZi9idWlsdGluLXByb2Jl
LmMNCj5AQCAtMzgwLDggKzM4MCwxMSBAQCBzdGF0aWMgaW50IHBlcmZfZGVsX3Byb2JlX2V2ZW50
cyhzdHJ1Y3Qgc3RyZmlsdGVyICpmaWx0ZXIpDQo+IAkJZ290byBvdXQ7DQo+DQo+IAlrbGlzdCA9
IHN0cmxpc3RfX25ldyhOVUxMLCBOVUxMKTsNCj4tCWlmICgha2xpc3QpDQo+LQkJcmV0dXJuIC1F
Tk9NRU07DQo+Kwl1bGlzdCA9IHN0cmxpc3RfX25ldyhOVUxMLCBOVUxMKTsNCj4rCWlmICgha2xp
c3QgfHwgIXVsaXN0KSB7DQo+KwkJcmV0ID0gLUVOT01FTTsNCj4rCQlnb3RvIG91dDsNCj4rCX0N
Cj4NCj4gCXJldCA9IHByb2JlX2ZpbGVfX2dldF9ldmVudHMoa2ZkLCBmaWx0ZXIsIGtsaXN0KTsN
Cj4gCWlmIChyZXQgPT0gMCkgew0KPg0KDQo=
