From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/9] perf test: Adding an entry for the
 perftool-testsuite
Date: Tue, 29 Mar 2016 14:57:20 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1603291437540.7107@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com> <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7> <20160327122340.GG4015@krava.sund.root.ku.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="571116545-45931462-1459256242=:7107"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbcC2M5Y (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2016 08:57:24 -0400
In-Reply-To: <20160327122340.GG4015@krava.sund.root.ku.dk>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--571116545-45931462-1459256242=:7107
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sun, 27 Mar 2016, Jiri Olsa wrote:
> On Wed, Mar 16, 2016 at 02:50:59PM +0100, Michael Petlan wrote:
>
> SNIP
>
>> +#define TESTSUITE_ROOT "./testsuite/"
>> +
>> +/* globals */
>> +int fatal_occured = 0;
>> +char *cwd;
>> +
>> +
>> +/* runs a shell script */
>> +int _run_shell(const char *script)
>> +{
>> +	int ret;
>> +	char *cmd = malloc(strlen(script) + 3 * sizeof(char));
>
> please check the return value

Fixed in the attached patch.


To the other notes:

> 'cwd' does not need to be global

Fixed in the attached patch.

> you propage all the error all the way through, so what's
> the point of having extra global fatal_occured variable?

It is reserved for distinguishing between a regular failures in the
tests (failures of perf in the ideal state) and the failures of the
infrastructure (cannot allocate memory for the *cmd string above).

     if(failures || fatal_occurred)
         test_status = TEST_FAIL;

I know that this idiom merges that into TEST_FAIL, but we still are
able to make differences here. The suite is pretty complex, I think
there should be a way to notice infrastructure failures.

> also I think you could erase the  ==== quoted lines

I think it is more human-eye-friendly when the sections are separated
by one more \n and the header. I moved that into the (verbose >= 2)
mode. Once there might be twice or thrice more lines and sections as
well. When reviewing the results of the suite, I like the headers.

> is there a point to run tests if the setup fails?

There is a reason, since not all of the tests of the 'group'
(base_something/test_*.sh) need the setup.


Thanks for the notes. The remaining two I have to check separately.
All the failures that I usually encounter have their stderrs cut
out in -v, so the testsuite logs look still nice. I have to check
the failure you posted.

Regarding to the C-c, yes, there are commands running in background,
we need that e.g. for `perf stat -p` testing. However I don't think
that that is why it cannot be C-c'd. I have to look at it more.

Michael

>
> jirka
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--571116545-45931462-1459256242=:7107
Content-Type: text/plain; charset=US-ASCII; name=suite.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LRH.2.20.1603291457200.7107@Rudolf-RHEL-7>
Content-Description: 
Content-Disposition: attachment; filename=suite.patch

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvc3VpdGUuYyBiL3Rvb2xz
L3BlcmYvdGVzdHMvc3VpdGUuYw0KaW5kZXggMTdmNjYxMC4uYjMzMTBlOCAx
MDA2NDQNCi0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvc3VpdGUuYw0KKysrIGIv
dG9vbHMvcGVyZi90ZXN0cy9zdWl0ZS5jDQpAQCAtMyw4ICszLDcgQEANCiAj
ZGVmaW5lIFRFU1RTVUlURV9ST09UICIuL3Rlc3RzdWl0ZS8iDQogDQogLyog
Z2xvYmFscyAqLw0KLWludCBmYXRhbF9vY2N1cmVkID0gMDsNCi1jaGFyICpj
d2Q7DQoraW50IGZhdGFsX29jY3VycmVkID0gMDsNCiANCiANCiAvKiBydW5z
IGEgc2hlbGwgc2NyaXB0ICovDQpAQCAtMTIsMTIgKzExLDE3IEBAIGludCBf
cnVuX3NoZWxsKGNvbnN0IGNoYXIgKnNjcmlwdCkNCiB7DQogCWludCByZXQ7
DQogCWNoYXIgKmNtZCA9IG1hbGxvYyhzdHJsZW4oc2NyaXB0KSArIDMgKiBz
aXplb2YoY2hhcikpOw0KKwlpZihjbWQgPT0gTlVMTCkNCisJew0KKwkJZnBy
aW50ZihzdGRlcnIsICJGQVRBTDogQ291bGQgbm90IGFsbG9jYXRlIG1lbW9y
eS5cbiIpOw0KKwkJcmV0dXJuIDE7DQorCX0NCiAJc3RyY3B5KGNtZCwgIi4v
Iik7DQogCXN0cmNweShjbWQgKyAyLCBzY3JpcHQpOw0KIAlyZXQgPSBzeXN0
ZW0oY21kKTsNCiAJaWYgKHJldCA9PSAtMSkgew0KIAkJZnByaW50ZihzdGRl
cnIsICJGQVRBTDogQ291bGQgbm90IHJ1biAlcyIsIGNtZCk7DQotCQlmYXRh
bF9vY2N1cmVkKys7DQorCQlmYXRhbF9vY2N1cnJlZCsrOw0KIAkJcmV0dXJu
IDE7DQogCX0NCiAJcmV0dXJuIHJldDsNCkBAIC0zMCwxMiArMzQsMTIgQEAg
aW50IHJ1bl9zaGVsbChjb25zdCBjaGFyICpzY3JpcHQpDQogCXN0cnVjdCBz
dGF0IHNiOw0KIA0KIAlpZiAoc3RhdChzY3JpcHQsICZzYikgPT0gLTEpIHsN
Ci0JCWZhdGFsX29jY3VyZWQrKzsNCisJCWZhdGFsX29jY3VycmVkKys7DQog
CQlyZXR1cm4gMTsNCiAJfQ0KIA0KIAlpZiAoISAoc2Iuc3RfbW9kZSAmIChT
X0lYVVNSIHwgU19JRlJFRykpKSB7DQotCQlmYXRhbF9vY2N1cmVkKys7DQor
CQlmYXRhbF9vY2N1cnJlZCsrOw0KIAkJcmV0dXJuIDE7DQogCX0NCiANCkBA
IC02OCw3ICs3Miw3IEBAIGludCBydW5fZ3JvdXAoY29uc3QgY2hhciAqcGF0
aCkNCiAJaW50IGZhaWx1cmVzID0gMDsNCiAJcmV0ID0gY2hkaXIocGF0aCk7
DQogDQotCWlmICh2ZXJib3NlKQ0KKwlpZiAodmVyYm9zZSA+IDEpDQogCQlw
cmludGYoIj09PT09PT09ICVzID09PT09PT09XG4iLCBwYXRoKTsNCiANCiAJ
LyogdHJ5IHRvIHJ1biBzZXR1cCAqLw0KQEAgLTEwMiwxMyArMTA2LDE0IEBA
IGludCBydW5fZ3JvdXAoY29uc3QgY2hhciAqcGF0aCkNCiBpbnQgdGVzdF9f
c3VpdGUoaW50IHN1YnRlc3QgX19tYXliZV91bnVzZWQpDQogew0KIAlESVIg
KmRwOw0KKwljaGFyICpjd2Q7DQogCXN0cnVjdCBkaXJlbnQgKmVwOw0KIAlp
bnQgZmFpbHVyZXMgPSAwOw0KIAlpbnQgcmV0Ow0KIAlpbnQgdGVzdF9zdGF0
dXMgPSBURVNUX09LOw0KIAljaGFyIHZlcmJvc2l0eV9zdHJbMl07DQogCWlu
dCBfdmVyYm9zZSA9ICh2ZXJib3NlID4gOSk/IDkgOiB2ZXJib3NlOw0KLQlj
aGFyIHRlbXBkaXJfdGVtcGxhdGVbMjRdLCBfdGVtcGRpcl90ZW1wbGF0ZTsN
CisJY2hhciB0ZW1wZGlyX3RlbXBsYXRlWzI0XSwgKl90ZW1wZGlyX3RlbXBs
YXRlOw0KIA0KIAkvKiBzZXQgdmVyYm9zaXR5IGFjY29yZGluZyB0byBwZXJm
LXRlc3QgY29tbWFuZCBsaW5lIHN3aXRjaGVzICovDQogCXNucHJpbnRmKHZl
cmJvc2l0eV9zdHIsIDIsICIlaSIsIF92ZXJib3NlKTsNCkBAIC0xNDMsNyAr
MTQ4LDcgQEAgaW50IHRlc3RfX3N1aXRlKGludCBzdWJ0ZXN0IF9fbWF5YmVf
dW51c2VkKQ0KIAlyZXQgPSByZXQ7DQogCWZyZWUoY3dkKTsNCiANCi0JaWYo
ZmFpbHVyZXMgfHwgZmF0YWxfb2NjdXJlZCkNCisJaWYoZmFpbHVyZXMgfHwg
ZmF0YWxfb2NjdXJyZWQpDQogCQl0ZXN0X3N0YXR1cyA9IFRFU1RfRkFJTDsN
CiANCiAJcmV0dXJuIHRlc3Rfc3RhdHVzOw0K

--571116545-45931462-1459256242=:7107--
