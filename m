From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/9] perf test: Adding an entry for the perftool-testsuite
Date: Sun, 27 Mar 2016 14:24:35 +0200
Message-ID: <20160327122435.GK4015@krava.sund.root.ku.dk>
References: <cover.1458134357.git.mpetlan@redhat.com>
 <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48982 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbcC0MYh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 27 Mar 2016 08:24:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

On Wed, Mar 16, 2016 at 02:50:59PM +0100, Michael Petlan wrote:
> In order to be able to run the bash/subcommand-based testsuite direct=
ly
> from perf test a new perf-test entry has been created for it.
>=20
> The driver (suite.c) runs all the tests  that it finds in the testsui=
te
> directory: tools/perf/testsuite/   (rather ./testsuite as it expects =
it
> it being run from the perf's directory).
>=20
> In case the testsuite is not found, the testcase is skipped. If this =
is
> not the desired behaviour, some packaging will be needed.
>=20
> Usage:
>     ./perf test suite
>=20
> or
>     ./perf test suite -v
>     ./perf test suite -vv
>=20
> (for the verbose output)
>=20
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

got following compile error:

  CC       tests/suite.o
tests/suite.c: In function =E2=80=98test__suite=E2=80=99:
tests/suite.c:119:20: error: assignment makes integer from pointer with=
out a cast [-Werror=3Dint-conversion]
  _tempdir_template =3D mkdtemp(tempdir_template);
                    ^
tests/suite.c:120:30: error: passing argument 2 of =E2=80=98setenv=E2=80=
=99 makes pointer from integer without a cast [-Werror=3Dint-conversion=
]
  setenv("PERFSUITE_RUN_DIR", _tempdir_template, 1);
                              ^
In file included from tests/suite.h:6:0,
                 from tests/suite.c:1:
/usr/include/stdlib.h:584:12: note: expected =E2=80=98const char *=E2=80=
=99 but argument is of type =E2=80=98char=E2=80=99
 extern int setenv (const char *__name, const char *__value, int __repl=
ace)
            ^
cc1: all warnings being treated as errors


moving on with attached patch

thanks,
jirka


---
diff --git a/tools/perf/tests/suite.c b/tools/perf/tests/suite.c
index 17f66107f34d..1561bec3a2e1 100644
--- a/tools/perf/tests/suite.c
+++ b/tools/perf/tests/suite.c
@@ -108,7 +108,8 @@ int test__suite(int subtest __maybe_unused)
 	int test_status =3D TEST_OK;
 	char verbosity_str[2];
 	int _verbose =3D (verbose > 9)? 9 : verbose;
-	char tempdir_template[24], _tempdir_template;
+	char tempdir_template[24];
+	char *_tempdir_template;
=20
 	/* set verbosity according to perf-test command line switches */
 	snprintf(verbosity_str, 2, "%i", _verbose);
