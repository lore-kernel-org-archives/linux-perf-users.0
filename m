From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: [PATCH] libbpf: Use PRIu64 for sym->st_value to fix build on 32-bit
 arches
Date: Wed, 27 Nov 2019 10:45:53 -0300
Message-ID: <20191127134553.GC22719@kernel.org>
References: <20191126183451.GC29071@kernel.org>
 <87d0dexyij.fsf@toke.dk>
 <20191126190450.GD29071@kernel.org>
 <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
 <20191126221018.GA22719@kernel.org>
 <20191126221733.GB22719@kernel.org>
 <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com>
 <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net>
 <20191126155228.0e6ed54c@cakuba.netronome.com>
 <20191127013901.GE29071@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191127013901.GE29071@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Stanislav Fomichev <sdf@fomichev.me>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Quentin Monnet <quentin.monnet@netronome.com>
List-Id: linux-perf-users.vger.kernel.org

Another fix I'm carrying in my perf/core branch,

Regards,

- Arnaldo

commit 98bb09f90a0ae33125fabc8f41529345382f1498
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Nov 27 09:26:54 2019 -0300

    libbpf: Use PRIu64 for sym->st_value to fix build on 32-bit arches
    
    The st_value field is a 64-bit value, so use PRIu64 to fix this error on
    32-bit arches:
    
      In file included from libbpf.c:52:
      libbpf.c: In function 'bpf_program__record_reloc':
      libbpf_internal.h:59:22: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'Elf64_Addr' {aka 'const long long unsigned int'} [-Werror=format=]
        libbpf_print(level, "libbpf: " fmt, ##__VA_ARGS__); \
                            ^~~~~~~~~~
      libbpf_internal.h:62:27: note: in expansion of macro '__pr'
       #define pr_warn(fmt, ...) __pr(LIBBPF_WARN, fmt, ##__VA_ARGS__)
                                 ^~~~
      libbpf.c:1822:4: note: in expansion of macro 'pr_warn'
          pr_warn("bad call relo offset: %lu\n", sym->st_value);
          ^~~~~~~
      libbpf.c:1822:37: note: format string is defined here
          pr_warn("bad call relo offset: %lu\n", sym->st_value);
                                         ~~^
                                         %llu
    
    Fixes: 1f8e2bcb2cd5 ("libbpf: Refactor relocation handling")
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Andrii Nakryiko <andriin@fb.com>
    Link: https://lkml.kernel.org/n/tip-iabs1wq19c357bkk84p7blif@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b20f82e58989..6b0eae5c8a94 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1819,7 +1819,7 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 			return -LIBBPF_ERRNO__RELOC;
 		}
 		if (sym->st_value % 8) {
-			pr_warn("bad call relo offset: %lu\n", sym->st_value);
+			pr_warn("bad call relo offset: %" PRIu64 "\n", sym->st_value);
 			return -LIBBPF_ERRNO__RELOC;
 		}
 		reloc_desc->type = RELO_CALL;
