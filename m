From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/9] perf test: new testsuite: perf annotate tests
Date: Tue, 15 Dec 2015 13:04:06 +0100
Message-ID: <20151215120406.GE5074@krava.brq.redhat.com>
References: <1449514394.24573.253.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964955AbbLOMEI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Dec 2015 07:04:08 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 9D9ACC0B930D
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Dec 2015 12:04:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1449514394.24573.253.camel@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, Dec 07, 2015 at 07:53:14PM +0100, Michael Petlan wrote:

SNIP

> +
> +	../common/check_all_patterns_found.pl "PERF-ANNOTATE" "NAME" "SYNOP=
SIS" "DESCRIPTION" "OPTIONS" "SEE ALSO" < basic_helpmsg.log
> +	CHECK_EXIT_CODE=3D$?
> +	../common/check_all_patterns_found.pl "perf\-annotate \- Read perf.=
data .* display annotated code" < basic_helpmsg.log
> +	(( CHECK_EXIT_CODE +=3D $? ))
> +	../common/check_all_patterns_found.pl "input" "dsos" "symbol" "forc=
e" "verbose" "dump-raw-trace" "vmlinux" "modules" < basic_helpmsg.log
> +	(( CHECK_EXIT_CODE +=3D $? ))
> +	../common/check_all_patterns_found.pl "print-line" "full-paths" "st=
dio" "tui" "cpu" "source" "symfs" "disassembler-style" < basic_helpmsg.=
log
> +	(( CHECK_EXIT_CODE +=3D $? ))
> +	../common/check_all_patterns_found.pl "objdump" "skip-missing" "gro=
up" < basic_helpmsg.log
> +	(( CHECK_EXIT_CODE +=3D $? ))

I know it's probably PITA, but would it make sense to preceed
each line with the actuall line you are expecting? like:

	###
	#  perf-annotate - Read perf.data (created by perf record) and display=
 annotated code
	#
	../common/check_all_patterns_found.pl "perf\-annotate \- Read perf.dat=
a .* display annotated code" < basic_helpmsg.log
	(( CHECK_EXIT_CODE +=3D $? ))

	###
	#   Disassembly of section load0:
        #       =E2=94=82    Disassembly of section load0:
        # 16.67 =E2=94=82      xor    %eax,%eax
	#=20
	../common/check_all_patterns_found.pl "$REGEX_HEADER load" "$REGEX_LIN=
E" "$REGEX_SECTION__TEXT" < basic_annotate.log
	CHECK_EXIT_CODE=3D$?

        ###
        # from =3D atol (argv[1]);
	#=20
	../common/check_all_patterns_found.pl "main" "from =3D atol" "from =3D=
 20L;" "for\s*\(i =3D 1L; j; \+\+i\)" "return 0;" < basic_annotate.log
	(( CHECK_EXIT_CODE +=3D $? ))


or some other way that would make it easy to find out what
the check is looking for in general

thanks,
jirka
