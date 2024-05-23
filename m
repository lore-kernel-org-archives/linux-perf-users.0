Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE082D91;
	Thu, 23 May 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489388; cv=none; b=l+vKEkqVh9ii2sZhPbIljD/rk/QC/GPBdxr+gv8jRdBwkKDTmJKK9n7y7jNy/lU5xkGH/1ykeiPJSTvqNkuHV31/GU90QOxxYh//7Ga48+yvOC4zziov59Pv4mX/lrPKKI/pUcJSimhwLjYelNM5CpepETaWGbO4ndACZ3EBddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489388; c=relaxed/simple;
	bh=VFpeRtPpQhUkwhyqwqGo4vObTY/oLSnQs6LBTi/EBEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soca2tfuDM3Adv1tN50xiAjybH8z/hypkYT0Us3dTjIWZzJ5aXwDQBsDHW9Fjkc5Mg+v4wzT4Mynb9Xlz3k2B8TaMsSAovWIErbYB2uNGki4DLlB+uOs38TWvbtQimUYZMldkFdrMc3/3GVcFNAfx+/mllYObIv8KokI/4PP4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXsxUG+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXsxUG+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB10C2BD10;
	Thu, 23 May 2024 18:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716489387;
	bh=VFpeRtPpQhUkwhyqwqGo4vObTY/oLSnQs6LBTi/EBEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXsxUG+GchLUuSO9SLiVVzAmH5Mkd84Rhv8T3mtZpWFSgk8i+GC28Pd8OD53GetXB
	 Sb9tVQdIhREhe8bVqq0QD4qsmQ6PksKEO7NO9Dyz5CC1ShTQWXxDuwOn92i/aShKU+
	 35e2exD4PRtu8OsT+oFWO6nwglYBpVBWTb7B2wIrTfiUPpbtgutr5+Lrvt6/o6BEq7
	 8fJguEJzCgMJjsBitGAUtjEAN8HGBXW2JgbL4iyq14UJ5C0OufL0kQrqSbEx9mgmYe
	 lghBdcQAvlq67FgS5QblF1BSIXT/ezPOztjCUegi7Uys7Gi1QWV7N3VKmddAm2Ykhc
	 +o32qQ70lYcxQ==
Date: Thu, 23 May 2024 15:36:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v5 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zk-MpqzRlAecrWA6@x1>
References: <20240523092920.3355004-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240523092920.3355004-1-sesse@google.com>

On Thu, May 23, 2024 at 11:29:18AM +0200, Steinar H. Gunderson wrote:
> In addition to the existing support for libbfd and calling out to
> an external addr2line command, add support for using libllvm directly.
> This is both faster than libbfd, and can be enabled in distro builds
> (the LLVM license has an explicit provision for GPLv2 compatibility).
> Thus, it is set as the primary choice if available.
>=20
> As an example, running perf report on a medium-size profile with
> DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
> libbfd, 153 seconds with external llvm-addr2line, and I got tired
> and aborted the test after waiting for 55 minutes with external
> bfd addr2line (which is the default for perf as compiled by distributions

Before this patch, using BFD's addr2line:

root@x1:~# echo 1 > /proc/sys/vm/drop_caches=20
root@x1:~# perf record --call-graph dwarf find / > /dev/null
[ perf record: Woken up 428 times to write data ]
[ perf record: Captured and wrote 107.598 MB perf.data (13355 samples) ]
root@x1:~#

root@x1:~# dnf debuginfo-install findutils

root@x1:~# perf report --no-children --stdio -s srcfile,srcline
# To display the perf.data header info, please use --header/--header-only o=
ptions.
#
# Total Lost Samples: 0
#
# Samples: 75  of event 'cpu_atom/cycles/P'
# Event count (approx.): 22073647
#
# Overhead  Source File        Source:Line                    =20
# ........  .................  ................................
#
     4.59%  disk-io.c          disk-io.c:108
            |
            ---btrfs_buffer_uptodate
               read_block_for_search
               |         =20
                --4.13%--btrfs_search_slot
                          btrfs_real_readdir
                          iterate_dir
                          __x64_sys_getdents64
                          do_syscall_64
                          entry_SYSCALL_64
<SNIP>

root@x1:~# echo 1 > /proc/sys/vm/drop_caches=20
root@x1:~# taskset -c 0 perf stat -e cpu_core/cycles/P perf report --no-chi=
ldren --stdio -s srcfile,srcline > /dev/null

 Performance counter stats for 'perf report --no-children --stdio -s srcfil=
e,srcline':

   225,837,039,942      cpu_core/cycles/P                                  =
                  =20

     113.192464730 seconds time elapsed

     102.789965000 seconds user
       6.478551000 seconds sys


root@x1:~#=20

Now with your patches:

Brownie points++:

Makefile.config:982: No libllvm found, slower source file resolution, pleas=
e install llvm-devel/llvm-dev

=2E..                                    llvm: [ OFF ]

But maybe use "libllvm"?

=E2=AC=A2[acme@toolbox perf-tools]$ sudo dnf install llvm-devel

=2E..                             libcapstone: [ on  ]
=2E..                                    llvm: [ on  ]

root@x1:~# echo 1 > /proc/sys/vm/drop_caches=20
root@x1:~# taskset -c 0 perf stat -e cpu_core/cycles/P perf report --no-chi=
ldren --stdio -s srcfile,srcline > /dev/null

 Performance counter stats for 'perf report --no-children --stdio -s srcfil=
e,srcline':

     2,462,040,637      cpu_core/cycles/P                                  =
                  =20

       1.696059762 seconds time elapsed

       1.013055000 seconds user
       0.423232000 seconds sys


root@x1:~#

root@x1:~# head -25 report.srcfile.srcline.libllvm=20
# To display the perf.data header info, please use --header/--header-only o=
ptions.
#
#
# Total Lost Samples: 0
#
# Samples: 75  of event 'cpu_atom/cycles/P'
# Event count (approx.): 22073647
#
# Overhead  Source File        Source:Line                    =20
# ........  .................  ................................
#
     4.59%  disk-io.c          disk-io.c:108
            |
            ---btrfs_buffer_uptodate
               read_block_for_search
               |         =20
                --4.13%--btrfs_search_slot
                          btrfs_real_readdir
                          iterate_dir
                          __x64_sys_getdents64
                          do_syscall_64
                          entry_SYSCALL_64
                          __GI___getdents64
                          __GI___readdir64
                          fts_build.constprop.0
root@x1:~#

=1A

Matches, now everything:

root@x1:~# diff -u report.srcfile.srcline.bfd report.srcfile.srcline.libllvm

--- report.srcfile.srcline.bfd	2024-05-23 14:31:26.717881878 -0300
+++ report.srcfile.srcline.libllvm	2024-05-23 14:22:37.795843724 -0300
@@ -23,6 +23,7 @@
                           __GI___getdents64
                           __GI___readdir64
                           fts_build.constprop.0
+                          rpl_fts_read (inlined)
                           find
                           process_all_startpoints
                           main

So mostly the above, and:

root@x1:~# perf probe -x /usr/bin/find -L find | grep fts_read
     44        while ( (errno=3D0, ent=3Dfts_read (p)) !=3D NULL )
               /* fts_read returned NULL; distinguish between "finished" an=
d "error". */
root@x1:~#

root@x1:~# readelf -wi /usr/lib/debug/usr/bin/find-4.9.0-5.fc39.x86_64.debu=
g | grep "DW_AT_name.*rpl_fts_read" -B2
 <1><2c69c>: Abbrev Number: 11 (DW_TAG_subprogram)
    <2c69d>   DW_AT_external    : 1
    <2c69d>   DW_AT_name        : (indirect string, offset: 0xda3): rpl_fts=
_read
--
 <1><364b8>: Abbrev Number: 25 (DW_TAG_subprogram)
    ^^^^^^^
    ^^^^^^^
    ^^^^^^^
    <364b9>   DW_AT_external    : 1
    <364b9>   DW_AT_name        : (indirect string, offset: 0xda3): rpl_fts=
_read

root@x1:~#

 <1><2c952>: Abbrev Number: 81 (DW_TAG_subprogram)
    ^^^^^^
    ^^^^^^
    ^^^^^^
    <2c953>   DW_AT_name        : (indirect string, offset: 0x118f): find
    <2c957>   DW_AT_decl_file   : 22
    <2c957>   DW_AT_decl_line   : 482
    <2c959>   DW_AT_decl_column : 1
    <2c959>   DW_AT_prototyped  : 1
    <2c959>   DW_AT_type        : <alt 0x573b>
    <2c95d>   DW_AT_sibling     : <0x2c996>

Then the function referring to the above that has inlined functions:

 <1><def8>: Abbrev Number: 2 (DW_TAG_subprogram)
    <def9>   DW_AT_abstract_origin: <0x2c952> <=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    <defd>   DW_AT_ranges      : 0xff0
    <df01>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <df03>   DW_AT_call_all_calls: 1
    <df03>   DW_AT_sibling     : <0xe84a>
 <2><df06>: Abbrev Number: 62 (DW_TAG_formal_parameter)
    <df07>   DW_AT_abstract_origin: <0x2c95f>
    <df0b>   DW_AT_location    : 0x8345 (location list)
    <df0f>   DW_AT_GNU_locviews: 0x833f
 <2><df13>: Abbrev Number: 52 (DW_TAG_variable)
    <df14>   DW_AT_abstract_origin: <0x2c96b>
    <df18>   DW_AT_location    : 3 byte block: 91 a0 7f 	(DW_OP_fbreg: -96)
<SNIP>
 <3><df77>: Abbrev Number: 51 (DW_TAG_inlined_subroutine)
    <df78>   DW_AT_abstract_origin: <0x364b8> <=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    <df7c>   DW_AT_entry_pc    : 0xeddf
    <df84>   DW_AT_GNU_entry_view: 0
    <df86>   DW_AT_ranges      : 0x1042
    <df8a>   DW_AT_call_file   : 6
    <df8b>   DW_AT_call_line   : 526
    <df8d>   DW_AT_call_column : 29
    <df8e>   DW_AT_sibling     : <0xe60d>
 <4><df91>: Abbrev Number: 62 (DW_TAG_formal_parameter)
    <df92>   DW_AT_abstract_origin: <0x364c3>
    <df96>   DW_AT_location    : 0x848f (location list)
    <df9a>   DW_AT_GNU_locviews: 0x8473
 <4><df9e>: Abbrev Number: 14 (DW_TAG_lexical_block)
    <df9f>   DW_AT_ranges      : 0x1042
<SNIP>

So the libllvm is even producing a better result, showing those inlines
not seen in the BFD based output.

So going from (BFD):

   225,837,039,942      cpu_core/cycles/P                                  =
                  =20

     113.192464730 seconds time elapsed

     102.789965000 seconds user
       6.478551000 seconds sys

To (using libllvm):

     2,462,040,637      cpu_core/cycles/P                                  =
                  =20

       1.696059762 seconds time elapsed

       1.013055000 seconds user
       0.423232000 seconds sys

100x speedup, looks like a win! 8-)

Thanks a lot, the comments I made on the patch are mostly coding style,
please consider them, but I wouldn't get in the way for this patch to
get merged because of that albeit would be nice to try to fit in more
nicely with the existing source code base.

Assuming the code remains the same after an eventual coding style
polish:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

The rest, more comments in the patch, after the diff output.

@@ -35,6 +36,7 @@
             ---__GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -56,6 +58,7 @@
             |          __GI___getdents64
             |          __GI___readdir64
             |          fts_build.constprop.0
+            |          rpl_fts_read (inlined)
             |          find
             |          process_all_startpoints
             |          main
@@ -75,6 +78,8 @@
                        0x55f742a0e9a3
                        0x55f742a0e9a3
                        0x55f742a02735
+                       0x55f742a02735
+                       0x55f742a02735
                        0x55f742a02f6d
                        0x55f742a037c4
                        0x55f7429fc0f7
@@ -90,6 +95,7 @@
                |          __fdopendir
                |          opendirat
                |          fts_build.constprop.0
+               |          rpl_fts_read (inlined)
                |          find
                |          process_all_startpoints
                |          main
@@ -98,6 +104,8 @@
                |          _start
                |         =20
                 --2.09%--__close
+                          left_dir (inlined)
+                          left_dir (inlined)
                           consider_visiting
                           find
                           process_all_startpoints
@@ -117,6 +125,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -152,6 +161,7 @@
                openat_safer
                opendirat
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -170,11 +180,13 @@
                do_syscall_64
                entry_SYSCALL_64
                __mmap64 (inlined)
-               __mmap64 (inlined)
+               mmap64
+               _dl_map_segment (inlined)
+               _dl_map_segments (inlined)
                _dl_map_object_from_fd
                _dl_map_object
                openaux
-               __GI__dl_catch_exception (inlined)
+               _dl_catch_exception
                _dl_map_object_deps
                dl_main
                _dl_sysdep_start
@@ -202,7 +214,8 @@
=20
      2.21%  do-rel.h           do-rel.h:133
             |
-            ---_dl_relocate_object
+            ---elf_dynamic_do_Rela (inlined)
+               _dl_relocate_object
                dl_main
                _dl_sysdep_start
                _dl_start_final (inlined)
@@ -216,6 +229,7 @@
                entry_SYSCALL_64
                __GI___fstatat64
                fts_stat.isra.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -231,6 +245,8 @@
                do_syscall_64
                entry_SYSCALL_64
                __close
+               left_dir (inlined)
+               left_dir (inlined)
                consider_visiting
                find
                process_all_startpoints
@@ -250,6 +266,7 @@
                entry_SYSCALL_64
                __GI___fstatat64
                fts_stat.isra.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -272,6 +289,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -303,6 +321,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -318,6 +337,7 @@
                pred_print
                apply_predicate
                apply_predicate
+               visit (inlined)
                consider_visiting
                find
                process_all_startpoints
@@ -331,6 +351,7 @@
             ---_int_free_create_chunk
                _int_free_merge_chunk
                cfree@GLIBC_2.2.5
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -340,7 +361,7 @@
=20
      2.09%  fts-cycle.c        fts-cycle.c:126
             |
-            ---leave_dir (inlined)
+            ---leave_dir.lto_priv.0
                0x7ffd0a6562af
=20
      2.09%                     __printf_buffer_to_file_switch+0
@@ -351,6 +372,7 @@
                pred_print
                apply_predicate
                apply_predicate
+               visit (inlined)
                consider_visiting
                find
                process_all_startpoints
@@ -371,6 +393,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -387,6 +410,8 @@
                do_syscall_64
                entry_SYSCALL_64
                __close
+               left_dir (inlined)
+               left_dir (inlined)
                consider_visiting
                find
                process_all_startpoints
@@ -403,6 +428,7 @@
                __GI___fstatat64
                fts_stat.isra.0
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -421,6 +447,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -432,7 +459,8 @@
             |
             ---_int_free
                cfree@GLIBC_2.2.5
-               leave_dir (inlined)
+               leave_dir.lto_priv.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -456,6 +484,7 @@
                openat_safer
                opendirat
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -474,6 +503,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -492,6 +522,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -505,6 +536,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -516,6 +548,7 @@
             |
             ---pred_and
                apply_predicate
+               visit (inlined)
                consider_visiting
                find
                process_all_startpoints
@@ -536,6 +569,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -553,6 +587,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -572,6 +607,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -591,6 +627,7 @@
                openat_safer
                opendirat
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -610,6 +647,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -620,6 +658,7 @@
      1.98%                     cfree@GLIBC_2.2.5+139
             |
             ---cfree@GLIBC_2.2.5
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -635,6 +674,8 @@
                do_syscall_64
                entry_SYSCALL_64
                __close
+               left_dir (inlined)
+               left_dir (inlined)
                consider_visiting
                find
                process_all_startpoints
@@ -655,6 +696,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -677,6 +719,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -695,6 +738,7 @@
                __GI___fstatat64
                fts_stat.isra.0
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -706,8 +750,9 @@
             |
             ---hash_find_entry
                hash_remove (inlined)
-               leave_dir (inlined)
+               leave_dir.lto_priv.0
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -740,6 +785,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -753,8 +799,9 @@
                safe_hasher (inlined)
                hash_find_entry
                hash_remove (inlined)
-               leave_dir (inlined)
+               leave_dir.lto_priv.0
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -799,6 +846,7 @@
                        |          0x7fc0e8e9ce16
                        |          0x55f742a1769f
                        |          0x55f742a03319
+                       |          0x55f742a03319
                        |          0x55f742a037c4
                        |          0x55f7429fc0f7
                        |          0x7fc0e8deb149
@@ -815,6 +863,7 @@
                                   0x7fc0e8e9ce16
                                   0x55f742a1769f
                                   0x55f742a03319
+                                  0x55f742a03319
                                   0x55f742a037c4
                                   0x55f7429fc0f7
                                   0x7fc0e8deb149
@@ -837,6 +886,7 @@
             |                     |          0x7fc0e8e9ce16
             |                     |          0x55f742a1769f
             |                     |          0x55f742a03319
+            |                     |          0x55f742a03319
             |                     |          0x55f742a037c4
             |                     |          0x55f7429fc0f7
             |                     |          0x7fc0e8deb149
@@ -852,6 +902,7 @@
             |                                0x7fc0e8e9ce16
             |                                0x55f742a1769f
             |                                0x55f742a03319
+            |                                0x55f742a03319
             |                                0x55f742a037c4
             |                                0x55f7429fc0f7
             |                                0x7fc0e8deb149
@@ -870,6 +921,7 @@
                        entry_SYSCALL_64
                        __GI___fstatat64
                        fts_stat.isra.0
+                       rpl_fts_read (inlined)
                        find
                        process_all_startpoints
                        main
@@ -898,6 +950,7 @@
                        |          __GI___getdents64
                        |          __GI___readdir64
                        |          fts_build.constprop.0
+                       |          rpl_fts_read (inlined)
                        |          find
                        |          process_all_startpoints
                        |          main
@@ -913,6 +966,7 @@
                                   __GI___getdents64
                                   __GI___readdir64
                                   fts_build.constprop.0
+                                  rpl_fts_read (inlined)
                                   find
                                   process_all_startpoints
                                   main
@@ -935,6 +989,7 @@
                                              __GI___getdents64
                                              __GI___readdir64
                                              fts_build.constprop.0
+                                             rpl_fts_read (inlined)
                                              find
                                              process_all_startpoints
                                              main
@@ -947,6 +1002,7 @@
             |
             ---__GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -971,6 +1027,7 @@
                                   0x55f742a17439
                                   |         =20
                                    --0.90%--0x55f742a03545
+                                             0x55f742a03545
                                              0x55f742a037c4
                                              0x55f7429fc0f7
                                              0x7fc0e8deb149
@@ -988,6 +1045,7 @@
                __GI___getdents64
                __GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -1019,6 +1077,7 @@
                        0x7fc0e8e9ce16
                        0x55f742a1769f
                        0x55f742a03319
+                       0x55f742a03319
                        0x55f742a037c4
                        0x55f7429fc0f7
                        0x7fc0e8deb149
@@ -1042,6 +1101,7 @@
                                   0x7fc0e8e9ce16
                                   0x55f742a1769f
                                   0x55f742a03319
+                                  0x55f742a03319
                                   0x55f742a037c4
                                   0x55f7429fc0f7
                                   0x7fc0e8deb149
@@ -1052,6 +1112,7 @@
             |
             ---__GI___readdir64
                fts_build.constprop.0
+               rpl_fts_read (inlined)
                find
                process_all_startpoints
                main
@@ -3292,5 +3353,5 @@
=20
=20
 #
-# (Tip: For hierarchical output, try: perf report --hierarchy)
+# (Tip: For memory address profiling, try: perf mem record / perf mem repo=
rt)
 #

> today). Evidently, for this case, the bfd addr2line process needs
> 18 seconds (on a 5.2 GHz Zen 3) to load the .debug ELF in question,
> hits the 1-second timeout and gets killed during initialization,
> getting restarted anew every time. Having an in-process addr2line
> makes this much more robust.
>=20
> As future extensions, libllvm can be used in many other places where
> we currently use libbfd or other libraries:
>=20
>  - Symbol enumeration (in particular, for PE binaries).
>  - Demangling (including non-Itanium demangling, e.g. Microsoft
>    or Rust).
>  - Disassembling (perf annotate).
>=20
> However, these are much less pressing; most people don't profile
> PE binaries, and perf has non-bfd paths for ELF. The same with
> demangling; the default _cxa_demangle path works fine for most
> users. Disassembling is coming in a later patch in the series;
> however do note that while bfd objdump can be slow on large binaries,
> it is possible to use --objdump=3Dllvm-objdump to get the speed benefits.
> (It appears LLVM-based demangling is very simple, should we want
> that.)
>=20
> Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
> correctly detected using feature_check, and thus was not tested.
>=20
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> ---
>  tools/build/Makefile.feature       |   1 +
>  tools/perf/Makefile.config         |  15 ++++
>  tools/perf/builtin-version.c       |   1 +
>  tools/perf/util/Build              |   1 +
>  tools/perf/util/llvm-c-helpers.cpp | 130 +++++++++++++++++++++++++++++
>  tools/perf/util/llvm-c-helpers.h   |  47 +++++++++++
>  tools/perf/util/srcline.c          |  57 ++++++++++++-
>  7 files changed, 251 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/util/llvm-c-helpers.cpp
>  create mode 100644 tools/perf/util/llvm-c-helpers.h
>=20
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 1e2ab148d5db..278b26216254 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -136,6 +136,7 @@ FEATURE_DISPLAY ?=3D              \
>           libunwind              \
>           libdw-dwarf-unwind     \
>           libcapstone            \
> +         llvm                   \

libllvm please

>           zlib                   \
>           lzma                   \
>           get_cpuid              \
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..414a37f712bd 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -969,6 +969,21 @@ ifdef BUILD_NONDISTRO
>    endif
>  endif
> =20
> +ifndef NO_LLVM

NO_LIBLLVM

> +  $(call feature_check,llvm)
> +  ifeq ($(feature-llvm), 1)
> +    CFLAGS +=3D -DHAVE_LLVM_SUPPORT
> +    CXXFLAGS +=3D -DHAVE_LLVM_SUPPORT
> +    CXXFLAGS +=3D $(shell $(LLVM_CONFIG) --cxxflags)
> +    LIBLLVM =3D $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG=
) --system-libs)
> +    EXTLIBS +=3D -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
> +    $(call detected,CONFIG_LLVM)
> +  else
> +    $(warning No libllvm found, slower source file resolution, please in=
stall llvm-devel/llvm-dev)
> +    NO_LLVM :=3D 1
> +  endif
> +endif
> +
>  ifndef NO_DEMANGLE
>    $(call feature_check,cxa-demangle)
>    ifeq ($(feature-cxa-demangle), 1)
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 398aa53e9e2e..94d8e13a688f 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -65,6 +65,7 @@ static void library_status(void)
>  	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
>  	STATUS(HAVE_DEBUGINFOD_SUPPORT, debuginfod);
>  	STATUS(HAVE_LIBELF_SUPPORT, libelf);
> +	STATUS(HAVE_LLVM_SUPPORT, libllvm);

HAVE_LIBLLVM_SUPPORT to be consistent

>  	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
>  	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
>  	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index da64efd8718f..32c4e5e634ed 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -226,6 +226,7 @@ perf-$(CONFIG_CXX_DEMANGLE) +=3D demangle-cxx.o
>  perf-y +=3D demangle-ocaml.o
>  perf-y +=3D demangle-java.o
>  perf-y +=3D demangle-rust.o
> +perf-$(CONFIG_LLVM) +=3D llvm-c-helpers.o
> =20
>  ifdef CONFIG_JITDUMP
>  perf-$(CONFIG_LIBELF) +=3D jitdump.o
> diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-=
helpers.cpp
> new file mode 100644
> index 000000000000..cde3f1f03af0
> --- /dev/null
> +++ b/tools/perf/util/llvm-c-helpers.cpp
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Must come before the linux/compiler.h include, which defines several
> + * macros (e.g. noinline) that conflict with compiler builtins used
> + * by LLVM.
> + */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM =
<=3D 15 */
> +#include <llvm/DebugInfo/Symbolize/Symbolize.h>
> +#pragma GCC diagnostic pop
> +
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <linux/compiler.h>
> +#include "symbol_conf.h"
> +#include "llvm-c-helpers.h"
> +
> +using namespace llvm;
> +using llvm::symbolize::LLVMSymbolizer;
> +
> +/*
> + * Allocate a static LLVMSymbolizer, which will live to the end of the p=
rogram.
> + * Unlike the bfd paths, LLVMSymbolizer has its own cache, so we do not =
need
> + * to store anything in the dso struct.
> + */
> +static LLVMSymbolizer *get_symbolizer()
> +{
> +	static LLVMSymbolizer *instance =3D nullptr;
> +	if (instance =3D=3D nullptr) {
> +		LLVMSymbolizer::Options opts;
> +		/*
> +		 * LLVM sometimes demangles slightly different from the rest
> +		 * of the code, and this mismatch can cause new_inline_sym()
> +		 * to get confused and mark non-inline symbol as inlined
> +		 * (since the name does not properly match up with base_sym).
> +		 * Thus, disable the demangling and let the rest of the code
> +		 * handle it.
> +		 */
> +		opts.Demangle =3D false;
> +		instance =3D new LLVMSymbolizer(opts);
> +	}
> +	return instance;
> +}
> +
> +/* Returns 0 on error, 1 on success. */
> +static int extract_file_and_line(const DILineInfo& line_info, char **fil=
e,
> +				 unsigned int *line)
> +{
> +	if (file) {
> +		if (line_info.FileName =3D=3D "<invalid>") {
> +			/* Match the convention of libbfd. */
> +			*file =3D nullptr;
> +		} else {
> +			/* The caller expects to get something it can free(). */
> +			*file =3D strdup(line_info.FileName.c_str());
> +			if (*file =3D=3D nullptr)
> +				return 0;
> +		}
> +	}
> +	if (line)
> +		*line =3D line_info.Line;
> +	return 1;
> +}
> +
> +extern "C"
> +int llvm_addr2line(const char *dso_name, u64 addr,
> +		   char **file, unsigned int *line,
> +		   bool unwind_inlines,
> +		   llvm_a2l_frame** inline_frames)
> +{
> +	LLVMSymbolizer *symbolizer =3D get_symbolizer();
> +	object::SectionedAddress sectioned_addr =3D {
> +		addr,
> +		object::SectionedAddress::UndefSection
> +	};
> +
> +	if (unwind_inlines) {
> +		Expected<DIInliningInfo> res_or_err =3D
> +			symbolizer->symbolizeInlinedCode(dso_name,
> +							 sectioned_addr);
> +		if (!res_or_err)
> +			return 0;
> +		unsigned num_frames =3D res_or_err->getNumberOfFrames();
> +		if (num_frames =3D=3D 0)
> +			return 0;
> +
> +		if (extract_file_and_line(
> +			res_or_err->getFrame(0), file, line) =3D=3D 0)

Please don't break this line or at least align 'file' with res_or_err.

> +			return 0;
> +
> +		*inline_frames =3D (llvm_a2l_frame*)malloc(
> +			sizeof(**inline_frames) * num_frames);

Do we really need to cast here (my C++ is super rusty), and why not
calloc()?

> +		if (*inline_frames =3D=3D nullptr)
> +			return 0;
> +
> +		for (unsigned i =3D 0; i < num_frames; ++i) {
> +			const DILineInfo& src =3D res_or_err->getFrame(i);

Add blank line here

> +			llvm_a2l_frame& dst =3D (*inline_frames)[i];
> +			if (src.FileName =3D=3D "<invalid>")
> +				/* Match the convention of libbfd. */
> +				dst.filename =3D nullptr;
> +			else
> +				dst.filename =3D strdup(src.FileName.c_str());
> +			dst.funcname =3D strdup(src.FunctionName.c_str());

If strdup fails, users will cope?

> +			dst.line =3D src.Line;
> +
> +			if (dst.filename =3D=3D nullptr ||
> +			    dst.funcname =3D=3D nullptr) {
> +				for (unsigned j =3D 0; j <=3D i; ++j) {
> +					free((*inline_frames)[j].filename);
> +					free((*inline_frames)[j].funcname);

Normally we use zfree()

> +				}
> +				free(*inline_frames);
> +				return 0;
> +			}
> +		}
> +
> +		return num_frames;
> +	} else {
> +		if (inline_frames)
> +			*inline_frames =3D nullptr;
> +
> +		Expected<DILineInfo> res_or_err =3D
> +			symbolizer->symbolizeCode(dso_name, sectioned_addr);

same line?

> +		if (!res_or_err)
> +			return 0;
> +		return extract_file_and_line(*res_or_err, file, line);
> +	}
> +}
> diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-he=
lpers.h
> new file mode 100644
> index 000000000000..1b28cdc9f9b7
> --- /dev/null
> +++ b/tools/perf/util/llvm-c-helpers.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_LLVM_C_HELPERS
> +#define __PERF_LLVM_C_HELPERS 1
> +
> +/*
> + * Helpers to call into LLVM C++ code from C, for the parts that do not =
have
> + * C APIs.
> + */
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +struct llvm_a2l_frame {
> +	char *filename;
> +	char *funcname;
> +	unsigned int line;
> +};
> +
> +/*
> + * Implement addr2line() using libLLVM. LLVM is a C++ API, and
> + * many of the linux/ headers cannot be included in a C++ compile unit,
> + * so we need to make a little bridge code here. llvm_addr2line() will
> + * convert the inline frame information from LLVM's internal structures
> + * and put them into a flat array given in inline_frames. The caller
> + * is then responsible for taking that array and convert it into perf's
> + * regular inline frame structures (which depend on e.g. struct list_hea=
d).
> + *
> + * If the address could not be resolved, or an error occurred (e.g. OOM),
> + * returns 0. Otherwise, returns the number of inline frames (which mean=
s 1
> + * if the address was not part of an inlined function). If unwind_inlines
> + * is set and the return code is nonzero, inline_frames will be set to
> + * a newly allocated array with that length. The caller is then responsi=
ble
> + * for freeing both the strings and the array itself.
> + */
> +int llvm_addr2line(const char *dso_name,
> +		   u64 addr,
> +		   char **file,
> +		   unsigned int *line,
> +		   bool unwind_inlines,
> +		   struct llvm_a2l_frame **inline_frames);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __PERF_LLVM_C_HELPERS */
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 9d670d8c1c08..0505b4c16608 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -16,6 +16,9 @@
>  #include "util/debug.h"
>  #include "util/callchain.h"
>  #include "util/symbol_conf.h"
> +#ifdef HAVE_LLVM_SUPPORT
> +#include "util/llvm-c-helpers.h"
> +#endif
>  #include "srcline.h"
>  #include "string2.h"
>  #include "symbol.h"
> @@ -130,7 +133,59 @@ static struct symbol *new_inline_sym(struct dso *dso,
> =20
>  #define MAX_INLINE_NEST 1024
> =20
> -#ifdef HAVE_LIBBFD_SUPPORT
> +#ifdef HAVE_LLVM_SUPPORT
> +
> +static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
> +				    int num_frames)
> +{
> +	if (inline_frames !=3D NULL) {
> +		for (int i =3D 0; i < num_frames; ++i) {
> +			free(inline_frames[i].filename);
> +			free(inline_frames[i].funcname);

zfree()?

> +		}
> +		free(inline_frames);
> +	}
> +}
> +
> +static int addr2line(const char *dso_name, u64 addr,
> +		     char **file, unsigned int *line, struct dso *dso,
> +		     bool unwind_inlines, struct inline_node *node,
> +		     struct symbol *sym)
> +{
> +	struct llvm_a2l_frame *inline_frames =3D NULL;
> +	int num_frames =3D llvm_addr2line(dso_name, addr, file, line,
> +					node && unwind_inlines, &inline_frames);
> +
> +	if (num_frames =3D=3D 0 || !inline_frames) {
> +		/* Error, or we didn't want inlines. */
> +		return num_frames;
> +	}
> +
> +	for (int i =3D 0; i < num_frames; ++i) {
> +		struct symbol *inline_sym =3D
> +			new_inline_sym(dso, sym, inline_frames[i].funcname);
> +		char *srcline =3D NULL;
> +
> +		if (inline_frames[i].filename)
> +			srcline =3D srcline_from_fileline(

move first arg to same line of function call

> +				inline_frames[i].filename,
> +				inline_frames[i].line);
> +		if (inline_list__append(inline_sym, srcline, node) !=3D 0) {
> +			free_llvm_inline_frames(inline_frames, num_frames);
> +			return 0;
> +		}
> +	}
> +	free_llvm_inline_frames(inline_frames, num_frames);
> +
> +	return num_frames;
> +}
> +
> +void dso__free_a2l(struct dso *)
> +{
> +	/* Nothing to free. */
> +}
> +
> +#elif defined(HAVE_LIBBFD_SUPPORT)
> =20
>  /*
>   * Implement addr2line using libbfd.
> --=20
> 2.45.1
