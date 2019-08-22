From: James Clark <James.Clark@arm.com>
Subject: [PATCH] Fixes hang in zstd compression test by changing the source of
 random data.
Date: Thu, 22 Aug 2019 13:55:15 +0000
Message-ID: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <447EEAA9459EB547B3B9A406E27F76C0@eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "namhyung@kernel.org" <namhyung@kernel.org>, "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, nd <nd@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Linton <Jeremy.Linton@arm.com>
List-Id: linux-perf-users.vger.kernel.org

UnVubmluZyAncGVyZiB0ZXN0JyB3aXRoIHpzdGQgY29tcHJlc3Npb24gbGlua2VkIHdpbGwgaGFu
ZyBhdCB0aGUgdGVzdA0KJ1pzdGQgcGVyZi5kYXRhIGNvbXByZXNzaW9uL2RlY29tcHJlc3Npb24n
IGJlY2F1c2UgL2Rldi9yYW5kb20gYmxvY2tzDQpyZWFkcyB1bnRpbCB0aGVyZSBpcyBlbm91Z2gg
ZW50cm9weS4gVGhpcyBtZWFucyB0aGF0IHRoZSB0ZXN0IHdpbGwNCmFwcGVhciB0byBuZXZlciBj
b21wbGV0ZSB1bmxlc3MgdGhlIG1vdXNlIGlzIGNvbnRpbnVhbGx5IG1vdmVkIHdoaWxlDQpydW5u
aW5nIGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBDbGFyayA8amFtZXMuY2xhcmtAYXJtLmNv
bT4NCi0tLQ0KIHRvb2xzL3BlcmYvdGVzdHMvc2hlbGwvcmVjb3JkK3pzdGRfY29tcF9kZWNvbXAu
c2ggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3RzL3NoZWxsL3JlY29yZCt6c3RkX2NvbXBf
ZGVjb21wLnNoIGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9yZWNvcmQrenN0ZF9jb21wX2RlY29t
cC5zaA0KaW5kZXggODk5NjA0ZDEuLjYzYTkxZWMgMTAwNzU1DQotLS0gYS90b29scy9wZXJmL3Rl
c3RzL3NoZWxsL3JlY29yZCt6c3RkX2NvbXBfZGVjb21wLnNoDQorKysgYi90b29scy9wZXJmL3Rl
c3RzL3NoZWxsL3JlY29yZCt6c3RkX2NvbXBfZGVjb21wLnNoDQpAQCAtMTMsNyArMTMsNyBAQCBz
a2lwX2lmX25vX3pfcmVjb3JkKCkgew0KIGNvbGxlY3Rfel9yZWNvcmQoKSB7DQogCWVjaG8gIkNv
bGxlY3RpbmcgY29tcHJlc3NlZCByZWNvcmQgZmlsZToiDQogCSRwZXJmX3Rvb2wgcmVjb3JkIC1v
ICR0cmFjZV9maWxlIC1nIC16IC1GIDUwMDAgLS0gXA0KLQkJZGQgY291bnQ9NTAwIGlmPS9kZXYv
cmFuZG9tIG9mPS9kZXYvbnVsbA0KKwkJZGQgY291bnQ9NTAwIGlmPS9kZXYvdXJhbmRvbSBvZj0v
ZGV2L251bGwNCiB9DQogDQogY2hlY2tfY29tcHJlc3NlZF9zdGF0cygpIHsNCi0tIA0KMi43LjQN
Cg0K
