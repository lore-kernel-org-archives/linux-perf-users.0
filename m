From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf annotate: Support of full source file paths for
 srcline fix
Date: Mon, 9 Nov 2015 16:39:54 -0300
Message-ID: <20151109193954.GD4715@kernel.org>
References: <1447083211.15375.57.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60274 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbbKITj7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 Nov 2015 14:39:59 -0500
Content-Disposition: inline
In-Reply-To: <1447083211.15375.57.camel@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org

Em Mon, Nov 09, 2015 at 04:33:31PM +0100, Michael Petlan escreveu:
> 
> The --full-paths option did not show the full source file paths
> in the perf annotate tool, because the value of the option was
> not propagated into the related functions.
> 
> With this patch the value of the --full-paths option is known to
> the function that composes the srcline string, so it prints the
> full path when necessary.

Thanks, applied, but you forgot to show when this happens, how it looks
before and after, I did it this time, please consider doing it this way
next time, so that I can more quickly reproduce your steps, reproduce
the problem, apply the patch, test the end result, matching your
findings.

Also please send it to me, CC ing other people that touched this code,
then CC it to linux-perf-users/lkml.

Thanks for the patch,

- Arnaldo

commit e1d13c36cd043a335de33845443f5d172f0eb543
Author: Michael Petlan <mpetlan@redhat.com>
Date:   Mon Nov 9 16:33:31 2015 +0100

    perf annotate: Support full source file paths for srcline fix
    
    The --full-paths option did not show the full source file paths in the 'perf
    annotate' tool, because the value of the option was not propagated into the
    related functions.
    
    With this patch the value of the --full-paths option is known to the function
    that composes the srcline string, so it prints the full path when necessary.
    
    Committer Note:
    
    This affects annotate when the --print-line option is used:
    
      # perf annotate -h 2>&1 | grep print-line
          -l, --print-line      print matching source lines (may be slow)
    
    Looking just at the lines that should be affected by this change:
    
    Before:
    
      # perf annotate --print-line --full-paths --stdio fput | grep '\.[ch]:[0-9]\+'
         94.44 atomic64_64.h:114
          5.56 file_table.c:265
       file_table.c:265    5.56 :	  ffffffff81219a00:       callq  ffffffff81769360 <__fentry__>
       atomic64_64.h:114   94.44 :	  ffffffff81219a05:       lock decq 0x38(%rdi)
    
    After:
    
      # perf annotate --print-line --full-paths --stdio fput | grep '\.[ch]:[0-9]\+'
         94.44 /home/git/linux/arch/x86/include/asm/atomic64_64.h:114
          5.56 /home/git/linux/fs/file_table.c:265
       /home/git/linux/fs/file_table.c:265    5.56 :	  ffffffff81219a00:       callq  ffffffff81769360 <__fentry__>
       /home/git/linux/arch/x86/include/asm/atomic64_64.h:114   94.44 :	  ffffffff81219a05:       lock decq 0x38(%rdi)
      #
    
    Signed-off-by: Michael Petlan <mpetlan@redhat.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Link: http://permalink.gmane.org/gmane.linux.kernel.perf.user/2365
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f2974da0185a..1dd1949b0e79 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1620,6 +1620,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	len = symbol__size(sym);
 
 	if (print_lines) {
+		srcline_full_filename = full_paths;
 		symbol__get_source_line(sym, map, evsel, &source_line, len);
 		print_summary(&source_line, dso->long_name);
 	}
