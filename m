From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v2] perf test shell: Fix check open filename arg using
 'perf trace
Date: Tue, 12 Dec 2017 04:05:23 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1712120133380.9416@Diego>
References: <alpine.LRH.2.20.1712081845230.9416@Diego> <20171211154312.GC2221@redhat.com> <20171211170750.GE3958@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="571116033-2070542650-1513047925=:9416"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbdLLDF0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Dec 2017 22:05:26 -0500
In-Reply-To: <20171211170750.GE3958@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--571116033-2070542650-1513047925=:9416
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Dec 2017, Arnaldo Carvalho de Melo wrote:
> It is not working here:

Hmm, I think I got it.

The following construction:

evts=`perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_(.*) +\[.*/-e \1/'`

... expands to:

"-e open -e openat"

... which is a format that perf-trace does not seem to accept.
It simply overrides the first event with the second, thus it
only traces "openat". It worked for me, since I tested it on
aarch64 where $evts expanded to only one "-e" parameter.

Attaching a patch for perf-trace that should address it. It
seems to work, so perf-trace accepts "-e open -e openat".
However, one weak point is there:

"-e open,openat -e stat" works, while
"-e open -e openat,stat" does not.

In case you don't like the patch for perf-trace, the test's
patch would need to expand events to something else (which is
of course possible).

Also, on my system (x86_64, 4.15.0-rc1), I needed another
patch for the test (perf_test_shell_fix_filename_arg.patch),
because the variable name changed...

> [root@jouet mnt]# perf test -v 62
> 62: Check open filename arg using perf trace + vfs_getname:
> --- start ---
> test child forked, pid 4919
> Added new event:
>   probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:vfs_getname -aR sleep 1
> 
> test child finished with -1
> ---- end ----
> Check open filename arg using perf trace + vfs_getname: FAILED!
> [root@jouet mnt]#
> 
> and when I run this with strace -e open to see if it is picking the
> right script, it is:
> 
> open("/home/acme/libexec/perf-core/tests/shell/record+script_probe_vfs_getname.sh", O_RDONLY) = 4
> open("/home/acme/libexec/perf-core/tests/shell/trace+probe_libc_inet_pton.sh", O_RDONLY) = 4
> open("/home/acme/libexec/perf-core/tests/shell/trace+probe_vfs_getname.sh", O_RDONLY) = 4
> 62: Check open filename arg using perf trace + vfs_getname:
> --- start ---
> test child forked, pid 4947
> Added new event:
>   probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:vfs_getname -aR sleep 1
> 
> --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=4947, si_uid=0, si_status=255, si_utime=0, si_stime=0} ---
> test child finished with -1
> ---- end ----
> Check open filename arg using perf trace + vfs_getname: FAILED!
> open("/home/acme/libexec/perf-core/tests/shell/probe_vfs_getname.sh", O_RDONLY) = 4
> +++ exited with 0 +++
> [root@jouet mnt]# 
> 
> [acme@jouet linux]$ diff -u /home/acme/libexec/perf-core/tests/shell/probe_vfs_getname.sh tools/perf/tests/shell/probe_vfs_getname.sh 
> [acme@jouet linux]$ git log --oneline -1
> 0553ba305e4e (HEAD -> perf/core) perf test shell: Fix check open filename arg using 'perf trace
> [acme@jouet linux]$ 
> 
> So can you please check if the file you're using is the one in this
> patch submission?

So attaching all three patches to be sure. I have tested them on
two environments:

  * x86_64 with 4.15.0-rc1
  * aarch64 with 4.14.0

Both work with all three patches applied, applying on perf/core's
head (commit 26ea2ece7802f8fdaaacf321dbfb22de3271ab82).

> 
> - Arnaldo
> 

Thanks for your patience :)

Cheers,
Michael
--571116033-2070542650-1513047925=:9416
Content-Type: text/plain; charset=US-ASCII; name=perf_trace_support_multiple_-e_arguments.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LRH.2.20.1712120405230.9416@Diego>
Content-Description: 
Content-Disposition: attachment; filename=perf_trace_support_multiple_-e_arguments.patch

Y29tbWl0IGI4YWJkMGY0OWQ2ODBjOWY5NDNhYzQ2MGE1ZWJhMjkxNDI0YmI2
ZDANCkF1dGhvcjogTWljaGFlbCBQZXRsYW4gPG1wZXRsYW5AcmVkaGF0LmNv
bT4NCkRhdGU6ICAgVHVlIERlYyAxMiAwMzo0MzoxMSAyMDE3ICswMTAwDQoN
CiAgICBwZXJmIHRyYWNlOiBzdXBwb3J0IG11bHRpcGxlIC1lIGFyZ3VtZW50
cw0KICAgIA0KICAgIE90aGVyIHBlcmYgc3ViY29tbWFuZHMsIHN1Y2ggYXMg
cGVyZi1zdGF0IGFsbG93IG11bHRpcGxlIGV2ZW50IHNwZWNpZmljYXRpb24N
CiAgICBhcmd1bWVudHMsIGxpa2UgInBlcmYgc3RhdCAtZSBldnQxIC1lIGV2
dDIgLi4uIi4NCiAgICANCiAgICBUaGlzIHBhdGNoIGVuYWJsZXMgcGVyZi10
cmFjZSB0byBhbGxvdyB0aGF0IHRvby4NCiAgICANCiAgICBCZWZvcmU6DQog
ICAgICAgICAwLjAzMCAoIDAuMDA0IG1zKTogdHJ1ZS8xOTE3MyBjbG9zZShm
ZDogMykgPSAwDQogICAgICAgICAwLjA4OSAoIDAuMDA3IG1zKTogdHJ1ZS8x
OTE3MyBjbG9zZShmZDogMykgPSAwDQogICAgDQogICAgQWZ0ZXI6DQogICAg
ICAgICAwLjAxOCAoIDAuMDEzIG1zKTogdHJ1ZS8xOTE3NSBvcGVuKGZpbGVu
YW1lOiAvZXRjL2xkLnNvLmNhY2hlLCBmbGFnczogQ0xPRVhFQykgPSAzDQog
ICAgICAgICAwLjA0MCAoIDAuMDA0IG1zKTogdHJ1ZS8xOTE3NSBjbG9zZShm
ZDogMzwvZXRjL2xkLnNvLmNhY2hlPikgPSAwDQogICAgICAgICAwLjA1MyAo
IDAuMDE0IG1zKTogdHJ1ZS8xOTE3NSBvcGVuKGZpbGVuYW1lOiAvbGliNjQv
bGliYy5zby42LCBmbGFnczogQ0xPRVhFQykgPSAzDQogICAgICAgICAwLjEw
NyAoIDAuMDA2IG1zKTogdHJ1ZS8xOTE3NSBjbG9zZShmZDogMzwvbGliNjQv
bGliYy5zby42PikgPSAwDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBQZXRsYW4gPG1wZXRsYW5AcmVkaGF0LmNvbT4NCg0KZGlmZiAtLWdp
dCBhL3Rvb2xzL3BlcmYvYnVpbHRpbi10cmFjZS5jIGIvdG9vbHMvcGVyZi9i
dWlsdGluLXRyYWNlLmMNCmluZGV4IDdjNTc4OTguLmFiY2ZkY2MgMTAwNjQ0
DQotLS0gYS90b29scy9wZXJmL2J1aWx0aW4tdHJhY2UuYw0KKysrIGIvdG9v
bHMvcGVyZi9idWlsdGluLXRyYWNlLmMNCkBAIC0yOTM1LDEwICsyOTM1LDE4
IEBAIHN0YXRpYyBpbnQgdHJhY2VfX3BhcnNlX2V2ZW50c19vcHRpb24oY29u
c3Qgc3RydWN0IG9wdGlvbiAqb3B0LCBjb25zdCBjaGFyICpzdHIsDQogCQkJ
LmRpcm5hbWUgPSBzdHJhY2VfZ3JvdXBzX2RpciwNCiAJCX07DQogDQotCQl0
cmFjZS0+ZXZfcXVhbGlmaWVyID0gc3RybGlzdF9fbmV3KGxpc3RzWzFdLCAm
c2xpc3RfY29uZmlnKTsNCiAJCWlmICh0cmFjZS0+ZXZfcXVhbGlmaWVyID09
IE5VTEwpIHsNCi0JCQlmcHV0cygiTm90IGVub3VnaCBtZW1vcnkgdG8gcGFy
c2UgZXZlbnQgcXVhbGlmaWVyIiwgdHJhY2UtPm91dHB1dCk7DQotCQkJZ290
byBvdXQ7DQorCQkJdHJhY2UtPmV2X3F1YWxpZmllciA9IHN0cmxpc3RfX25l
dyhsaXN0c1sxXSwgJnNsaXN0X2NvbmZpZyk7DQorCQkJaWYgKHRyYWNlLT5l
dl9xdWFsaWZpZXIgPT0gTlVMTCkgew0KKwkJCQlmcHV0cygiTm90IGVub3Vn
aCBtZW1vcnkgdG8gcGFyc2UgZXZlbnQgcXVhbGlmaWVyIiwgdHJhY2UtPm91
dHB1dCk7DQorCQkJCWdvdG8gb3V0Ow0KKwkJCX0NCisJCX0gZWxzZSB7DQor
CQkJaW50IHJ2ID0gc3RybGlzdF9fYWRkKHRyYWNlLT5ldl9xdWFsaWZpZXIs
IGxpc3RzWzFdKTsNCisJCQlpZiAocnYgIT0gMCkgew0KKwkJCQlmcHV0cygi
QSBwcm9ibGVtIG9jY3VycmVkIHdoZW4gcGFyc2luZyBldmVudCBxdWFsaWZp
ZXIiLCB0cmFjZS0+b3V0cHV0KTsNCisJCQkJZ290byBvdXQ7DQorCQkJfQ0K
IAkJfQ0KIA0KIAkJaWYgKHRyYWNlX192YWxpZGF0ZV9ldl9xdWFsaWZpZXIo
dHJhY2UpKQ0K

--571116033-2070542650-1513047925=:9416
Content-Type: text/plain; charset=US-ASCII; name=perf_test_shell_fix_filename_arg.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LRH.2.20.1712120405231.9416@Diego>
Content-Description: 
Content-Disposition: attachment; filename=perf_test_shell_fix_filename_arg.patch

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvbGliL3Byb2Jl
X3Zmc19nZXRuYW1lLnNoIGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9saWIv
cHJvYmVfdmZzX2dldG5hbWUuc2gNCmluZGV4IDMwYTk1MGMuLjM3NTk1ODIg
MTAwNjQ0DQotLS0gYS90b29scy9wZXJmL3Rlc3RzL3NoZWxsL2xpYi9wcm9i
ZV92ZnNfZ2V0bmFtZS5zaA0KKysrIGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVs
bC9saWIvcHJvYmVfdmZzX2dldG5hbWUuc2gNCkBAIC0xMyw3ICsxMyw3IEBA
IGFkZF9wcm9iZV92ZnNfZ2V0bmFtZSgpIHsNCiAJbG9jYWwgdmVyYm9zZT0k
MQ0KIAlpZiBbICRoYWRfdmZzX2dldG5hbWUgLWVxIDEgXSA7IHRoZW4NCiAJ
CWxpbmU9JChwZXJmIHByb2JlIC1MIGdldG5hbWVfZmxhZ3MgMj4mMSB8IGVn
cmVwICdyZXN1bHQuKj0uKmZpbGVuYW1lOycgfCBzZWQgLXIgJ3MvW1s6c3Bh
Y2U6XV0rKFtbOmRpZ2l0Ol1dKylbWzpzcGFjZTpdXStyZXN1bHQtPnVwdHIu
Ki9cMS8nKQ0KLQkJcGVyZiBwcm9iZSAkdmVyYm9zZSAidmZzX2dldG5hbWU9
Z2V0bmFtZV9mbGFnczoke2xpbmV9IHBhdGhuYW1lPXJlc3VsdC0+bmFtZTpz
dHJpbmciDQorCQlwZXJmIHByb2JlICR2ZXJib3NlICJ2ZnNfZ2V0bmFtZT1n
ZXRuYW1lX2ZsYWdzOiR7bGluZX0gcGF0aG5hbWU9ZmlsZW5hbWU6c3RyaW5n
Ig0KIAlmaQ0KIH0NCiANCg==

--571116033-2070542650-1513047925=:9416
Content-Type: text/plain; charset=US-ASCII; name=perf_test_shell_fix_check_open_filename_arg__v2.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LRH.2.20.1712120405232.9416@Diego>
Content-Description: 
Content-Disposition: attachment; filename=perf_test_shell_fix_check_open_filename_arg__v2.patch

Y29tbWl0IDkyMjgxYTlmZjczZjk4ZDhhY2E3NTk1NTA0MzQwYTI1YzkyYjlm
MWENCkF1dGhvcjogTWljaGFlbCBQZXRsYW4gPG1wZXRsYW5AcmVkaGF0LmNv
bT4NCkRhdGU6ICAgRnJpIERlYyA4IDE4OjQzOjE4IDIwMTcgKzAxMDANCg0K
ICAgIHBlcmYgdGVzdCBzaGVsbDogRml4IGNoZWNrIG9wZW4gZmlsZW5hbWUg
YXJnIHVzaW5nICdwZXJmIHRyYWNlJw0KICAgIA0KICAgIFRoZSBmb2xsb3dp
bmcgY29tbWl0IGFkZGVkIGFuIGV4Y2VwdGlvbiBmb3IgczM5MHggdG8gdXNl
IG9wZW5hdCgpDQogICAgaW5zdGVhZCBvZiBvcGVuKCkgaW4gdGhlIHRlc3Q6
DQogICAgDQogICAgICBjb21taXQgZjIzMWFmNzg5YjExYTJmMWEzNzk1YWNj
MzIyOGEzZTE3OGE4MGMyMQ0KICAgICAgQXV0aG9yOiBUaG9tYXMgUmljaHRl
ciA8dG1yaWNodEBsaW51eC52bmV0LmlibS5jb20+DQogICAgICBEYXRlOiAg
IFR1ZSBOb3YgMTQgMDg6MTg6NDYgMjAxNyArMDEwMA0KICAgIA0KICAgIFNp
bmNlIHRoZSBwcm9ibGVtIGlzIG5vdCBzMzkweC1zcGVjaWZpYywgdGhpcyBw
YXRjaCBtYWtlcyBpdCBtb3JlDQogICAgZ2VuZXJpYywgc28gdGhlIHRlc3Qg
aGFuZGxlcyBib3RoIG9wZW4oKSBhbmQgb3BlbmF0KCkgbm8gbWF0dGVyDQog
ICAgd2hpY2ggYXJjaGl0ZWN0dXJlIGl0IGlzIHJ1bm5pbmcgb24uDQogICAg
DQogICAgU2lnbmVkLW9mZi1ieTogTWljaGFlbCBQZXRsYW4gPG1wZXRsYW5A
cmVkaGF0LmNvbT4NCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMv
c2hlbGwvdHJhY2UrcHJvYmVfdmZzX2dldG5hbWUuc2ggYi90b29scy9wZXJm
L3Rlc3RzL3NoZWxsL3RyYWNlK3Byb2JlX3Zmc19nZXRuYW1lLnNoDQppbmRl
eCAyYTllZjA4Li5lZGQxMDczIDEwMDc1NQ0KLS0tIGEvdG9vbHMvcGVyZi90
ZXN0cy9zaGVsbC90cmFjZStwcm9iZV92ZnNfZ2V0bmFtZS5zaA0KKysrIGIv
dG9vbHMvcGVyZi90ZXN0cy9zaGVsbC90cmFjZStwcm9iZV92ZnNfZ2V0bmFt
ZS5zaA0KQEAgLTE3LDEwICsxNyw5IEBAIHNraXBfaWZfbm9fcGVyZl9wcm9i
ZSB8fCBleGl0IDINCiBmaWxlPSQobWt0ZW1wIC90bXAvdGVtcG9yYXJ5X2Zp
bGUuWFhYWFgpDQogDQogdHJhY2Vfb3Blbl92ZnNfZ2V0bmFtZSgpIHsNCi0J
dGVzdCAiJCh1bmFtZSAtbSkiID0gczM5MHggJiYgeyBzdmM9Im9wZW5hdCI7
IHR4dD0iZGZkOiArQ1dELCArIjsgfQ0KLQ0KLQlwZXJmIHRyYWNlIC1lICR7
c3ZjOi1vcGVufSB0b3VjaCAkZmlsZSAyPiYxIHwgXA0KLQllZ3JlcCAiICtb
MC05XStcLlswLTldKyArXCggK1swLTldK1wuWzAtOV0rIG1zXCk6ICt0b3Vj
aFwvWzAtOV0rICR7c3ZjOi1vcGVufVwoJHt0eHR9ZmlsZW5hbWU6ICske2Zp
bGV9LCArZmxhZ3M6IENSRUFUXHxOT0NUVFlcfE5PTkJMT0NLXHxXUk9OTFks
ICttb2RlOiArSVJVR09cfElXVUdPXCkgKz0gK1swLTldKyQiDQorCWV2dHM9
YHBlcmYgbGlzdCBzeXNjYWxsczpzeXNfZW50ZXJfb3BlbiogfCYgZWdyZXAg
J29wZW4oYXQpPyAnIHwgc2VkIC1yICdzLy4qc3lzX2VudGVyXyguKikgK1xb
LiovLWUgXDEvJ2ANCisJcGVyZiB0cmFjZSAkZXZ0cyB0b3VjaCAkZmlsZSAy
PiYxIHwgXA0KKwllZ3JlcCAiICtbMC05XStcLlswLTldKyArXCggK1swLTld
K1wuWzAtOV0rIG1zXCk6ICt0b3VjaFwvWzAtOV0rIG9wZW4oYXQpP1woKGRm
ZDogK0NXRCwgKyk/ZmlsZW5hbWU6ICske2ZpbGV9LCArZmxhZ3M6IENSRUFU
XHxOT0NUVFlcfE5PTkJMT0NLXHxXUk9OTFksICttb2RlOiArSVJVR09cfElX
VUdPXCkgKz0gK1swLTldKyQiDQogfQ0KIA0KIA0K

--571116033-2070542650-1513047925=:9416--
