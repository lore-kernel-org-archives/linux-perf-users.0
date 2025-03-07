Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C97257AC7;
	Fri,  7 Mar 2025 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380374; cv=none; b=A7El/k/SzdRxNJu2HlDagrFHvDeS05PEl69w/1pcU+6o6mNA7LUE7Ujgqrm5Wm8t3Jq3UGfIyP3pRFQ18YM5Vc7x+alZCUqBKn9tNYsCqbPdo2IWuhcMRcLO2u1lasWZgLxV/jeVaJecAIQgOoc+4Hcn5AmpHUl/SKE1leOM+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380374; c=relaxed/simple;
	bh=vH3B2G8mPnZ0Vn4SWEkEXyHTOOqIOVypjdD5j3REujk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOqzRj8QKyJrtP/tgolFIPy+UiZaQtb4CTQIdrDUG4tzwKRmALxOHSzjiKqK5knfdJcf2tH7SHLLohnI0iC49MZKMj5JQ7guMi5jUByPBrh2PJw0B7A8CDRSM46qTbm7cjmsGXRoi6a51oWSL2qvwlJMgjIfcucNJaKpV/XBKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9QwVTeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9QwVTeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32319C4CED1;
	Fri,  7 Mar 2025 20:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741380373;
	bh=vH3B2G8mPnZ0Vn4SWEkEXyHTOOqIOVypjdD5j3REujk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9QwVTeGRe3Oj/noO/+Ib7n4jNqYSm6CYOupKLeaUYM+rhL6CLTvkIHY4OLrXL61M
	 MInriMDdggUshLsVP+C1qswvejcc34dmgLD7CGBRt8Keexv14XI4xE7W6UnoeevgAM
	 0qUHlib3FPxhlrER4p7/UUd54AuvVgaPWeS+hN9csSXaYvV2Zvxc0AwK8HT+T8l9YB
	 IsI0yQ6GSqD51GsYVh4qMovQClSY8N5xe7HMQMZj8cYezR0zM7UYyNAvcFKDNEW+U1
	 DcBRlWamRS7LTIY9+JiPQWz9YcJxWmqKz1KEcuSbKWIOakQkV2236PO7TBtGzsklnK
	 uEXKGMdRinpVw==
Date: Fri, 7 Mar 2025 17:46:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Support .gnu_debugdata for symbols in perf
Message-ID: <Z8tbEgh7rZscggv6@x1>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
 <Z7-QZKNT4Cc8lspM@google.com>
 <Z8tSyzcHF2V7Lofx@x1>
 <Z8tUmcIH1qTF6YTn@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8tUmcIH1qTF6YTn@x1>

On Fri, Mar 07, 2025 at 05:18:36PM -0300, Arnaldo Carvalho de Melo wrote:
> The NO_LZMA code in the perf build system should at this point either be
> deleted, as elfutils is so critical for perf, or mean that outside of
> elfutils, perf should make no use of lzma, which seems odd even with
> some potentially marginal value.
 
> So for testing this series I'll have to collect data before these
> patches get applied, making sure we collect samples from symbols in
> binaries with a MiniDebuginfo section, do a perf report, see them as
> being not resolved after making sure we don't have its debuginfo files
> installed and zapping whatever local debuginfo cache we have
> (debuginfod, perfs, etc), apply the patches and then see if it gets more
> symbols resolved by looking at the .gnu_debugdata section.
> 
> Ok, doing that now.

Works:

⬢ [acme@toolbox perf-tools-next]$ taskset -c 0 perf record -e cpu_core/cycles/P find . > /dev/null
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.011 MB perf.data (163 samples) ]
⬢ [acme@toolbox perf-tools-next]$ perf report --stdio > before
⬢ [acme@toolbox perf-tools-next]$ 

Apply the patches and:

⬢ [acme@toolbox perf-tools-next]$ perf report --stdio > after
⬢ [acme@toolbox perf-tools-next]$ diff -u before after
--- before	2025-03-07 17:33:15.113447391 -0300
+++ after	2025-03-07 17:33:39.291525994 -0300
@@ -9,88 +9,56 @@
 # Overhead  Command  Shared Object         Symbol                            
 # ........  .......  ....................  ..................................
 #
+     8.72%  find     find                  [.] consider_visiting
      7.90%  find     libc.so.6             [.] __GI___readdir64
      7.44%  find     libc.so.6             [.] _int_malloc
+     7.06%  find     find                  [.] find
+     6.20%  find     find                  [.] fts_build.constprop.0
      6.18%  find     libc.so.6             [.] __memmove_avx_unaligned_erms
+     4.36%  find     find                  [.] pred_print
      4.14%  find     libc.so.6             [.] __printf_buffer
      3.65%  find     libc.so.6             [.] __strlen_avx2
      3.35%  find     libc.so.6             [.] malloc
-     2.65%  find     find                  [.] 0x000000000000b498
+     2.85%  find     find                  [.] fts_alloc
      2.51%  find     libc.so.6             [.] __vfprintf_internal
      2.45%  find     libc.so.6             [.] __fprintf_chk
-     2.45%  find     find                  [.] 0x00000000000089e3
      2.33%  find     libc.so.6             [.] __printf_buffer_write
      2.13%  find     libc.so.6             [.] _int_free_merge_chunk
      1.88%  find     libc.so.6             [.] __printf_buffer_flush_to_file
-     1.87%  find     find                  [.] 0x000000000000bf8e
      1.79%  find     libc.so.6             [.] _int_free
      1.64%  find     libc.so.6             [.] msort_with_tmp.part.0
      1.63%  find     find                  [.] free@plt
-     1.34%  find     find                  [.] 0x000000000000c214
-     1.30%  find     find                  [.] 0x000000000001ea34
-     1.27%  find     find                  [.] 0x000000000001ea96
+     1.29%  find     find                  [.] fts_safe_changedir.lto_priv.0
      1.26%  find     [unknown]             [k] 0xffffffffad4001c8
      1.25%  find     libc.so.6             [.] __libc_fcntl64
      1.23%  find     libc.so.6             [.] _int_free_create_chunk
-     1.22%  find     find                  [.] 0x000000000000bfb9
-     1.22%  find     find                  [.] 0x000000000000bbde
-     1.22%  find     find                  [.] 0x000000000000b4a2
-     1.20%  find     find                  [.] 0x0000000000006918
+     1.20%  find     find                  [.] pred_and
      1.16%  find     libc.so.6             [.] __fcntl64_nocancel_adjusted
+     1.15%  find     find                  [.] AD_hash
      1.12%  find     libc.so.6             [.] cfree@GLIBC_2.2.5
      1.05%  find     libc.so.6             [.] __strchrnul_ifunc@plt
      1.03%  find     libc.so.6             [.] __libc_openat64
      1.01%  find     libc.so.6             [.] __strchrnul_avx2
-     0.69%  find     find                  [.] 0x0000000000008a0e
-     0.68%  find     find                  [.] 0x000000000000b553
-     0.67%  find     find                  [.] 0x000000000001ea63
-     0.67%  find     find                  [.] 0x0000000000006869
-     0.65%  find     find                  [.] 0x0000000000019e82
-     0.65%  find     find                  [.] 0x000000000000bbc5
-     0.65%  find     find                  [.] 0x000000000001117e
-     0.64%  find     find                  [.] 0x0000000000019fc6
-     0.64%  find     find                  [.] 0x000000000001111c
-     0.63%  find     find                  [.] 0x0000000000008a19
-     0.63%  find     find                  [.] 0x0000000000018b3d
-     0.63%  find     find                  [.] 0x000000000000b61e
+     0.97%  find     find                  [.] leave_dir.lto_priv.0
+     0.67%  find     find                  [.] apply_predicate
+     0.63%  find     find                  [.] cwd_advance_fd.lto_priv.0
      0.63%  find     libc.so.6             [.] __GI___fstatat64
-     0.63%  find     find                  [.] 0x000000000001f0de
      0.63%  find     libc.so.6             [.] __fstat64
-     0.63%  find     find                  [.] 0x000000000001edfb
-     0.62%  find     find                  [.] 0x000000000001113f
-     0.61%  find     find                  [.] 0x000000000000c223
-     0.61%  find     find                  [.] 0x000000000000c06b
-     0.61%  find     find                  [.] 0x000000000000fd90
-     0.61%  find     find                  [.] 0x0000000000018d98
-     0.60%  find     find                  [.] 0x0000000000017cfa
-     0.60%  find     find                  [.] 0x000000000001e990
-     0.60%  find     find                  [.] 0x000000000000b657
+     0.60%  find     find                  [.] rpl_fcntl
      0.59%  find     find                  [.] malloc@plt
-     0.59%  find     find                  [.] 0x000000000000c099
-     0.59%  find     find                  [.] 0x00000000000089d9
      0.58%  find     ld-linux-x86-64.so.2  [.] _dl_process_pt_gnu_property
      0.57%  find     libc.so.6             [.] unlink_chunk.isra.0
-     0.56%  find     find                  [.] 0x000000000001ea4e
-     0.56%  find     find                  [.] 0x000000000000b64b
      0.56%  find     libc.so.6             [.] malloc@plt
-     0.54%  find     find                  [.] 0x00000000000110e6
-     0.54%  find     find                  [.] 0x000000000001ead0
-     0.54%  find     find                  [.] 0x000000000000fdc7
-     0.53%  find     find                  [.] 0x000000000000fd8a
-     0.52%  find     find                  [.] 0x0000000000011e07
-     0.52%  find     find                  [.] 0x000000000000b6a8
-     0.48%  find     find                  [.] 0x0000000000012463
+     0.54%  find     find                  [.] fts_compare_ino
+     0.52%  find     find                  [.] hash_find_entry
+     0.48%  find     find                  [.] fts_sort
      0.47%  find     libc.so.6             [.] __printf_buffer_to_file_switch
      0.42%  find     libc.so.6             [.] alloc_perturb
-     0.42%  find     find                  [.] 0x000000000000bfc2
-     0.41%  find     find                  [.] 0x0000000000011179
-     0.40%  find     find                  [.] 0x000000000000c234
-     0.36%  find     find                  [.] 0x0000000000018cc0
      0.14%  find     ld-linux-x86-64.so.2  [.] _dl_sysdep_parse_arguments
      0.01%  find     ld-linux-x86-64.so.2  [.] _dl_start
      0.00%  find     ld-linux-x86-64.so.2  [.] _start
 
 
 #
-# (Tip: Create an archive with symtabs to analyse on other machine: perf archive)
+# (Tip: To see callchains in a more compact form: perf report -g folded)
 #
⬢ [acme@toolbox perf-tools-next]$

⬢ [acme@toolbox perf-tools-next]$ find ~/.debug/ -name af3f04d1b31abc9e5ce8428110e424fd980a37
⬢ [acme@toolbox perf-tools-next]$ find ~/.cache/ -name af3f04d1b31abc9e5ce8428110e424fd980a37
⬢ [acme@toolbox perf-tools-next]$ 
⬢ [acme@toolbox perf-tools-next]$ rpm -qf /bin/find
findutils-4.9.0-9.fc40.x86_64
⬢ [acme@toolbox perf-tools-next]$ rpm -q findutils-debuginfo
package findutils-debuginfo is not installed
⬢ [acme@toolbox perf-tools-next]$

And /bin/find has only unresolved symbols in its symtabs:

⬢ [acme@toolbox perf-tools-next]$ readelf -sW /bin/find | grep -w FUNC | wc -l
145
⬢ [acme@toolbox perf-tools-next]$ readelf -sW /bin/find | grep -w FUNC | grep -vw UND
⬢ [acme@toolbox perf-tools-next]$

⬢ [acme@toolbox perf-tools-next]$ readelf -SW /bin/find  | grep SYM
  [ 7] .dynsym           DYNSYM          00000000000004a0 0004a0 000ed0 18   A  8   1  8
  [ 9] .gnu.version      VERSYM          00000000000019a0 0019a0 00013c 02   A  7   0  2
⬢ [acme@toolbox perf-tools-next]$

And that matches eu-readelf output, almost the same (UND => UNDEF):

⬢ [acme@toolbox perf-tools-next]$ eu-readelf -s /bin/find | grep -w FUNC | wc -l
145
⬢ [acme@toolbox perf-tools-next]$
⬢ [acme@toolbox perf-tools-next]$ eu-readelf -s /bin/find | grep -w FUNC | grep -vw UNDEF
⬢ [acme@toolbox perf-tools-next]$

It has a way to use that section tho:

⬢ [acme@toolbox perf-tools-next]$ man eu-readelf | grep -A2 -- --elf-section
               [--elf-section [section] ]
               [-w|
                --debug-dump[=line,=decodedline,=info,=info+,=abbrev,=pubnames,=aranges,=macro,=frames,=str,=loc,=ranges,=gdb_index,=addr]]
--
       --elf-section [section]
           Use the named SECTION (default .gnu_debugdata) as (compressed) ELF input data

⬢ [acme@toolbox perf-tools-next]$

⬢ [acme@toolbox perf-tools-next]$ eu-readelf --elf-section -s /bin/find | grep -w FUNC | grep -vw UNDEF | wc -l
339
⬢ [acme@toolbox perf-tools-next]$ eu-readelf --elf-section -s /bin/find | grep -w FUNC | grep -vw UNDEF | head
    1: 00000000000056d0     35 FUNC    LOCAL  DEFAULT       17 entry_hashfunc
    2: 0000000000005700     34 FUNC    LOCAL  DEFAULT       17 entry_comparator
    3: 0000000000005920    121 FUNC    LOCAL  DEFAULT       17 subtree_has_side_effects
    4: 00000000000059a0    992 FUNC    LOCAL  DEFAULT       17 worst_cost.part.0
    5: 0000000000005d80    449 FUNC    LOCAL  DEFAULT       17 traverse_tree
    6: 0000000000005f50     73 FUNC    LOCAL  DEFAULT       17 undangle_file_pointers
    7: 0000000000005fa0     72 FUNC    LOCAL  DEFAULT       17 looks_like_expression
    8: 0000000000006030    303 FUNC    LOCAL  DEFAULT       17 get_fts_info_name
    9: 0000000000006190     35 FUNC    LOCAL  DEFAULT       17 inside_dir.part.0
   10: 0000000000006330    451 FUNC    LOCAL  DEFAULT       17 pred_sanity_check
⬢ [acme@toolbox perf-tools-next]$

So there we can find the new entries, such as the top one in the example
profile session above:

⬢ [acme@toolbox perf-tools-next]$ eu-readelf --elf-section -s /bin/find | grep -w FUNC | grep -vw UNDEF | grep -w consider_visiting
   48: 000000000000b460   2544 FUNC    LOCAL  DEFAULT       17 consider_visiting
⬢ [acme@toolbox perf-tools-next]$

And trat address matches the resolution perf did with your patches:

⬢ [acme@toolbox perf-tools-next]$ perf report -v --stdio |& head
build id event received for [vdso]: a2184b81fbbc08eff401d16259eca8ad5f9d8988 [20]
build id event received for /usr/bin/find: 3faf3f04d1b31abc9e5ce8428110e424fd980a37 [20]
build id event received for /usr/lib64/ld-linux-x86-64.so.2: 765f7ab0f3569ffe98de85864a0cedda9b686994 [20]
build id event received for /usr/lib64/libc.so.6: c8c3fa52aaee3f5d73b6fd862e39e9d4c010b6ba [20]
build id event received for [kernel.kallsyms]: c3fbb7df4dfb94762b1648bc65e4363e50f45585 [20]
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/find
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
⬢ [acme@toolbox perf-tools-next]$ perf report -v --stdio |& head -20
build id event received for [vdso]: a2184b81fbbc08eff401d16259eca8ad5f9d8988 [20]
build id event received for /usr/bin/find: 3faf3f04d1b31abc9e5ce8428110e424fd980a37 [20]
build id event received for /usr/lib64/ld-linux-x86-64.so.2: 765f7ab0f3569ffe98de85864a0cedda9b686994 [20]
build id event received for /usr/lib64/libc.so.6: c8c3fa52aaee3f5d73b6fd862e39e9d4c010b6ba [20]
build id event received for [kernel.kallsyms]: c3fbb7df4dfb94762b1648bc65e4363e50f45585 [20]
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/find
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 163  of event 'cpu_core/cycles/Pu'
# Event count (approx.): 68126524
#
# Overhead  Command  Shared Object                    Symbol                                                 
# ........  .......  ...............................  .......................................................
#
     8.72%  find     /usr/bin/find                    0xb498             
     7.90%  find     /usr/lib64/libc.so.6             0xe51e0            B [.] __GI___readdir64
     7.44%  find     /usr/lib64/libc.so.6             0xa77cd            B [.] _int_malloc
⬢ [acme@toolbox perf-tools-next]$

The only strange thing was not having it resolved in the -v case, which
I think its because you added a new type of DSO but didn't update the
code that does the 'perf report -v' verbose case?

I ran out of time, have to go AFK now, can you please take a look,
Stephen?

DSO_BINARY_TYPE__GNU_DEBUGDATA should be handled at...

int dso__read_binary_type_filename(const struct dso *dso,
                                   enum dso_binary_type type,
                                   char *root_dir, char *filename, size_t size)

But you have it there, ok, I'll try to continue later.

Other than that the patch looks great and makes use of this new mini
symtab, excellent!

- Arnaldo
