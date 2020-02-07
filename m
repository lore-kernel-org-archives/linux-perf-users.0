From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 01/10] capabilities: introduce CAP_PERFMON to kernel
 and user space
Date: Fri, 07 Feb 2020 11:38:11 +0000
Message-ID: <875zgizkyk.fsf@nanos.tec.linutronix.de>
References: <2b608e26-354b-3df9-aea9-58e56dc0c5e5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <2b608e26-354b-3df9-aea9-58e56dc0c5e5@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Alexey Budankov <alexey.budankov@linux.intel.com>, Stephen Smalley <sds@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Song Liu <songliubraving@fb.com>, Peter Zijlstra <peterz@infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Lionel Landwerlin <lionel.g.landwerlin@intel.com>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Robert Richter <rric@kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>"intel-gfx@lists.freedesktop.org" <int>
List-Id: linux-perf-users.vger.kernel.org

QWxleGV5IEJ1ZGFua292IDxhbGV4ZXkuYnVkYW5rb3ZAbGludXguaW50ZWwuY29tPiB3cml0ZXM6
Cj4gT24gMjIuMDEuMjAyMCAxNzoyNSwgQWxleGV5IEJ1ZGFua292IHdyb3RlOgo+PiBPbiAyMi4w
MS4yMDIwIDE3OjA3LCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6Cj4+Pj4gSXQga2VlcHMgdGhlIGlt
cGxlbWVudGF0aW9uIHNpbXBsZSBhbmQgcmVhZGFibGUuIFRoZSBpbXBsZW1lbnRhdGlvbiBpcyBt
b3JlCj4+Pj4gcGVyZm9ybWFudCBpbiB0aGUgc2Vuc2Ugb2YgY2FsbGluZyB0aGUgQVBJIC0gb25l
IGNhcGFibGUoKSBjYWxsIGZvciBDQVBfUEVSRk1PTgo+Pj4+IHByaXZpbGVnZWQgcHJvY2Vzcy4K
Pj4+Pgo+Pj4+IFllcywgaXQgYmxvYXRzIGF1ZGl0IGxvZyBmb3IgQ0FQX1NZU19BRE1JTiBwcml2
aWxlZ2VkIGFuZCB1bnByaXZpbGVnZWQgcHJvY2Vzc2VzLAo+Pj4+IGJ1dCB0aGlzIGJsb2F0aW5n
IGFsc28gYWR2ZXJ0aXNlcyBhbmQgbGV2ZXJhZ2VzIHVzaW5nIG1vcmUgc2VjdXJlIENBUF9QRVJG
TU9OCj4+Pj4gYmFzZWQgYXBwcm9hY2ggdG8gdXNlIHBlcmZfZXZlbnRfb3BlbiBzeXN0ZW0gY2Fs
bC4KPj4+Cj4+PiBJIGNhbiBsaXZlIHdpdGggdGhhdC7CoCBXZSBqdXN0IG5lZWQgdG8gZG9jdW1l
bnQgdGhhdCB3aGVuIHlvdSBzZWUKPj4+IGJvdGggYSBDQVBfUEVSRk1PTiBhbmQgYSBDQVBfU1lT
X0FETUlOIGF1ZGl0IG1lc3NhZ2UgZm9yIGEgcHJvY2VzcywKPj4+IHRyeSBvbmx5IGFsbG93aW5n
IENBUF9QRVJGTU9OIGZpcnN0IGFuZCBzZWUgaWYgdGhhdCByZXNvbHZlcyB0aGUKPj4+IGlzc3Vl
LsKgIFdlIGhhdmUgYSBzaW1pbGFyIGlzc3VlIHdpdGggQ0FQX0RBQ19SRUFEX1NFQVJDSCB2ZXJz
dXMKPj4+IENBUF9EQUNfT1ZFUlJJREUuCj4+IAo+PiBwZXJmIHNlY3VyaXR5IFsxXSBkb2N1bWVu
dCBjYW4gYmUgdXBkYXRlZCwgYXQgbGVhc3QsIHRvIGFsaWduIGFuZCBkb2N1bWVudCAKPj4gdGhp
cyBhdWRpdCBsb2dnaW5nIHNwZWNpZmljcy4KPgo+IEFuZCBJIHBsYW4gdG8gdXBkYXRlIHRoZSBk
b2N1bWVudCByaWdodCBhZnRlciB0aGlzIHBhdGNoIHNldCBpcyBhY2NlcHRlZC4KPiBGZWVsIGZy
ZWUgdG8gbGV0IG1lIGtub3cgb2YgdGhlIHBsYWNlcyBpbiB0aGUga2VybmVsIGRvY3MgdGhhdCBh
bHNvCj4gcmVxdWlyZSB1cGRhdGUgdy5yLnQgQ0FQX1BFUkZNT04gZXh0ZW5zaW9uLgoKVGhlIGRv
Y3VtZW50YXRpb24gdXBkYXRlIHdhbnRzIGJlIHBhcnQgb2YgdGhlIHBhdGNoIHNldCBhbmQgbm90
IHBsYW5uZWQKdG8gYmUgZG9uZSBfYWZ0ZXJfIHRoZSBwYXRjaCBzZXQgaXMgbWVyZ2VkLgoKVGhh
bmtzLAoKICAgICAgICB0Z2x4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
