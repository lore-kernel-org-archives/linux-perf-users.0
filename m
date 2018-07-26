From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: BPF relocation 'perf test' entries failing was: Re: [GIT PULL 00/27]
 perf/core improvements and fixes
Date: Thu, 26 Jul 2018 10:15:34 -0300
Message-ID: <20180726131534.GD17940@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <ast@fb.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Ingo Molnar <mingo@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Clark Williams <williams@redhat.com>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Jul 25, 2018 at 02:59:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Ingo,
> 
> 	Please consider pulling, I'm now investigating why these failed:
> 
>   38: LLVM search and compile                               :
>   38.1: Basic BPF llvm compile                              : Ok
>   38.2: kbuild searching                                    : Ok
>   38.3: Compile source for BPF prologue generation          : Ok
>   38.4: Compile source for BPF relocation                   : FAILED!
>   40: BPF filter                                            :
>   40.1: Basic BPF filtering                                 : Ok
>   40.2: BPF pinning                                         : Ok
>   40.3: BPF prologue generation                             : Ok
>   40.4: BPF relocation checker                              : FAILED!
> 
> 	I think these failures are not related to changes in this patch
> kit. Details about the test environment, versions, etc.

So, here are more details:

The relevant bit seems to be:

libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522

So this seems to be something that was caught by the kernel verifier and
now is being caught by libbpf, /me goes to read the tools/lib/bpf
changelog...

- Arnaldo

BPF filter subtest 2: Ok
40.3: BPF prologue generation                             :
--- start ---
test child forked, pid 13336
Kernel build dir is set to /lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
set env: KBUILD_DIR=/lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
unset env: KBUILD_OPTS
include option is set to  -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h 
set env: NR_CPUS=4
set env: LINUX_VERSION_CODE=0x41200
set env: CLANG_EXEC=/usr/lib64/ccache/clang
set env: CLANG_OPTIONS=-xc 
set env: KERNEL_INC_OPTIONS= -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h 
set env: PERF_BPF_INC_OPTIONS=-I/home/acme/lib/include/perf/bpf
set env: WORKING_DIR=/lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build
set env: CLANG_SOURCE=-
llvm compiling command template: echo '/*
 * bpf-script-test-relocation.c
 * Test BPF loader checking relocation
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt="-DLINUX_VERSION_CODE=0x40200" into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC("maps") my_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

int this_is_a_global_val;

SEC("func=sys_write")
int bpf_func__sys_write(void *ctx)
{
	int key = 0;
	int value = 0;

	/*
	 * Incorrect relocation. Should not allow this program be
	 * loaded into kernel.
	 */
	bpf_map_update_elem(&this_is_a_global_val, &key, &value, 0);
	return 0;
}
char _license[] SEC("license") = "GPL";
int _version SEC("version") = LINUX_VERSION_CODE;
' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS $KERNEL_INC_OPTIONS $PERF_BPF_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf -O2 -o -
llvm compiling command : echo '/*
 * bpf-script-test-relocation.c
 * Test BPF loader checking relocation
 */
#ifndef LINUX_VERSION_CODE
# error Need LINUX_VERSION_CODE
# error Example: for 4.2 kernel, put 'clang-opt=-DLINUX_VERSION_CODE=0x40200 into llvm section of ~/.perfconfig'
#endif
#define BPF_ANY 0
#define BPF_MAP_TYPE_ARRAY 2
#define BPF_FUNC_map_lookup_elem 1
#define BPF_FUNC_map_update_elem 2

static void *(*bpf_map_lookup_elem)(void *map, void *key) =
	(void *) BPF_FUNC_map_lookup_elem;
static void *(*bpf_map_update_elem)(void *map, void *key, void *value, int flags) =
	(void *) BPF_FUNC_map_update_elem;

struct bpf_map_def {
	unsigned int type;
	unsigned int key_size;
	unsigned int value_size;
	unsigned int max_entries;
};

#define SEC(NAME) __attribute__((section(NAME), used))
struct bpf_map_def SEC(maps) my_table = {
	.type = BPF_MAP_TYPE_ARRAY,
	.key_size = sizeof(int),
	.value_size = sizeof(int),
	.max_entries = 1,
};

int this_is_a_global_val;

SEC(func=sys_write)
int bpf_func__sys_write(void *ctx)
{
	int key = 0;
	int value = 0;

	/*
	 * Incorrect relocation. Should not allow this program be
	 * loaded into kernel.
	 */
	bpf_map_update_elem(&this_is_a_global_val, &key, &value, 0);
	return 0;
}
char _license[] SEC(license) = GPL;
int _version SEC(version) = LINUX_VERSION_CODE;
' | /usr/lib64/ccache/clang -D__KERNEL__ -D__NR_CPUS__=4 -DLINUX_VERSION_CODE=0x41200 -xc   -nostdinc -isystem /usr/lib/gcc/x86_64-redhat-linux/7/include -I/home/acme/git/linux/arch/x86/include -I./arch/x86/include/generated  -I/home/acme/git/linux/include -I./include -I/home/acme/git/linux/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/home/acme/git/linux/include/uapi -I./include/generated/uapi -include /home/acme/git/linux/include/linux/kconfig.h  -I/home/acme/lib/include/perf/bpf -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/4.18.0-rc6-00093-g9981b4fb8684/build -c - -target bpf -O2 -o -
libbpf: loading object '[bpf_relocation_test]' from buffer
libbpf: section(1) .strtab, size 115, link 0, flags 0, type=3
libbpf: skip section(1) .strtab
libbpf: section(2) .text, size 0, link 0, flags 6, type=1
libbpf: skip section(2) .text
libbpf: section(3) func=sys_write, size 104, link 0, flags 6, type=1
libbpf: found program func=sys_write
libbpf: section(4) .relfunc=sys_write, size 16, link 8, flags 0, type=9
libbpf: section(5) maps, size 16, link 0, flags 3, type=1
libbpf: section(6) license, size 4, link 0, flags 3, type=1
libbpf: license of [bpf_relocation_test] is GPL
libbpf: section(7) version, size 4, link 0, flags 3, type=1
libbpf: kernel version of [bpf_relocation_test] is 41200
libbpf: section(8) .symtab, size 144, link 1, flags 0, type=2
libbpf: maps in [bpf_relocation_test]: 1 maps in 16 bytes
libbpf: map 0 is "my_table"
libbpf: collecting relocating info for: 'func=sys_write'
libbpf: relo for 5 value 4 name 21
libbpf: Program 'func=sys_write' contains non-map related relo data pointing to section 65522
bpf: failed to load buffer
Compile BPF program failed.
test child finished with 0
---- end ----
BPF filter subtest 3: Ok
40.4: BPF relocation checker                              :
--- start ---
test child forked, pid 13746
test child finished with -1
---- end ----
BPF filter subtest 4: FAILED!
[root@seventh ~]#
