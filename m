From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 01/10] capabilities: introduce
 CAP_PERFMON to kernel and user space
Date: Thu, 20 Feb 2020 16:05:11 +0300
Message-ID: <95aa57e6-4d78-39df-386c-a98734f19777@linux.intel.com>
References: <875zgizkyk.fsf@nanos.tec.linutronix.de>
 <7d6f4210-423f-e454-3910-9f8e17dff1aa@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <7d6f4210-423f-e454-3910-9f8e17dff1aa@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thomas Gleixner <tglx@linutronix.de>, Stephen Smalley <sds@tycho.nsa.gov>, Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Song Liu <songliubraving@fb.com>, Peter Zijlstra <peterz@infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>, Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Igor Lubashev <ilubashe@akamai.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Robert Richter <rric@kernel.org>, "selinux@vger.kernel.org" <selinux@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Stephane
List-Id: linux-perf-users.vger.kernel.org

Ck9uIDA3LjAyLjIwMjAgMTY6MzksIEFsZXhleSBCdWRhbmtvdiB3cm90ZToKPiAKPiBPbiAwNy4w
Mi4yMDIwIDE0OjM4LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4+IEFsZXhleSBCdWRhbmtvdiA8
YWxleGV5LmJ1ZGFua292QGxpbnV4LmludGVsLmNvbT4gd3JpdGVzOgo+Pj4gT24gMjIuMDEuMjAy
MCAxNzoyNSwgQWxleGV5IEJ1ZGFua292IHdyb3RlOgo+Pj4+IE9uIDIyLjAxLjIwMjAgMTc6MDcs
IFN0ZXBoZW4gU21hbGxleSB3cm90ZToKPj4+Pj4+IEl0IGtlZXBzIHRoZSBpbXBsZW1lbnRhdGlv
biBzaW1wbGUgYW5kIHJlYWRhYmxlLiBUaGUgaW1wbGVtZW50YXRpb24gaXMgbW9yZQo+Pj4+Pj4g
cGVyZm9ybWFudCBpbiB0aGUgc2Vuc2Ugb2YgY2FsbGluZyB0aGUgQVBJIC0gb25lIGNhcGFibGUo
KSBjYWxsIGZvciBDQVBfUEVSRk1PTgo+Pj4+Pj4gcHJpdmlsZWdlZCBwcm9jZXNzLgo+Pj4+Pj4K
Pj4+Pj4+IFllcywgaXQgYmxvYXRzIGF1ZGl0IGxvZyBmb3IgQ0FQX1NZU19BRE1JTiBwcml2aWxl
Z2VkIGFuZCB1bnByaXZpbGVnZWQgcHJvY2Vzc2VzLAo+Pj4+Pj4gYnV0IHRoaXMgYmxvYXRpbmcg
YWxzbyBhZHZlcnRpc2VzIGFuZCBsZXZlcmFnZXMgdXNpbmcgbW9yZSBzZWN1cmUgQ0FQX1BFUkZN
T04KPj4+Pj4+IGJhc2VkIGFwcHJvYWNoIHRvIHVzZSBwZXJmX2V2ZW50X29wZW4gc3lzdGVtIGNh
bGwuCj4+Pj4+Cj4+Pj4+IEkgY2FuIGxpdmUgd2l0aCB0aGF0LsKgIFdlIGp1c3QgbmVlZCB0byBk
b2N1bWVudCB0aGF0IHdoZW4geW91IHNlZQo+Pj4+PiBib3RoIGEgQ0FQX1BFUkZNT04gYW5kIGEg
Q0FQX1NZU19BRE1JTiBhdWRpdCBtZXNzYWdlIGZvciBhIHByb2Nlc3MsCj4+Pj4+IHRyeSBvbmx5
IGFsbG93aW5nIENBUF9QRVJGTU9OIGZpcnN0IGFuZCBzZWUgaWYgdGhhdCByZXNvbHZlcyB0aGUK
Pj4+Pj4gaXNzdWUuwqAgV2UgaGF2ZSBhIHNpbWlsYXIgaXNzdWUgd2l0aCBDQVBfREFDX1JFQURf
U0VBUkNIIHZlcnN1cwo+Pj4+PiBDQVBfREFDX09WRVJSSURFLgo+Pj4+Cj4+Pj4gcGVyZiBzZWN1
cml0eSBbMV0gZG9jdW1lbnQgY2FuIGJlIHVwZGF0ZWQsIGF0IGxlYXN0LCB0byBhbGlnbiBhbmQg
ZG9jdW1lbnQgCj4+Pj4gdGhpcyBhdWRpdCBsb2dnaW5nIHNwZWNpZmljcy4KPj4+Cj4+PiBBbmQg
SSBwbGFuIHRvIHVwZGF0ZSB0aGUgZG9jdW1lbnQgcmlnaHQgYWZ0ZXIgdGhpcyBwYXRjaCBzZXQg
aXMgYWNjZXB0ZWQuCj4+PiBGZWVsIGZyZWUgdG8gbGV0IG1lIGtub3cgb2YgdGhlIHBsYWNlcyBp
biB0aGUga2VybmVsIGRvY3MgdGhhdCBhbHNvCj4+PiByZXF1aXJlIHVwZGF0ZSB3LnIudCBDQVBf
UEVSRk1PTiBleHRlbnNpb24uCj4+Cj4+IFRoZSBkb2N1bWVudGF0aW9uIHVwZGF0ZSB3YW50cyBi
ZSBwYXJ0IG9mIHRoZSBwYXRjaCBzZXQgYW5kIG5vdCBwbGFubmVkCj4+IHRvIGJlIGRvbmUgX2Fm
dGVyXyB0aGUgcGF0Y2ggc2V0IGlzIG1lcmdlZC4KPiAKPiBXZWxsLCBhY2NlcHRlZC4gSXQgaXMg
Z29pbmcgdG8gbWFrZSBwYXRjaGVzICMxMSBhbmQgYmV5b25kLgoKUGF0Y2hlcyAjMTEgYW5kICMx
MiBvZiB2NyBbMV0gY29udGFpbiBpbmZvcm1hdGlvbiBvbiBDQVBfUEVSRk1PTiBpbnRlbnRpb24g
YW5kIHVzYWdlLgpQYXRjaCBmb3IgbWFuLXBhZ2VzIFsyXSBleHRlbmRzIHBlcmZfZXZlbnRfb3Bl
bi4yIGRvY3VtZW50YXRpb24uCgpUaGFua3MsCkFsZXhleQoKLS0tClsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sL2M4ZGU5MzdhLTBiM2EtNzE0Ny1mNWVmLTY5ZjQ2N2U4N2ExM0BsaW51
eC5pbnRlbC5jb20vClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE4ZDEwODNkLWVm
ZTUtZjVmOC1jNTMxLWQxNDJjMGU1YzFhOEBsaW51eC5pbnRlbC5jb20vCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBsaXN0
CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
