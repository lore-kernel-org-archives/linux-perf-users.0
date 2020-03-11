From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf documentation: Add desription forHEADER_TRACING_DATA
Date: Wed, 11 Mar 2020 10:58:15 -0300
Message-ID: <20200311135815.GD19277@kernel.org>
References: <20200303070846.18335-1-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200303070846.18335-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Mar 03, 2020 at 08:08:46AM +0100, Thomas Richter escreveu:
> Add description and layout in the perf.data file for
> the header part describing trace data used in commands
> perf record -e XXX
> where XXX is a probe or tracepoint.

Did you write this from scratch?  I was going thru it and couldn't find
what that "Note member 'ftrace_count' can be zero." refers to, couldn't
find this ftrace_counter, is this outdated?

[root@five ~]# find /sys/kernel/debug/tracing/events/ -type f | xargs grep ftrace_count
[root@five ~]# find /sys/kernel/debug/tracing/events/ -name ftrace_count
[root@five ~]# uname -a
Linux five 5.5.5-200.fc31.x86_64 #1 SMP Wed Feb 19 23:28:07 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]#

The part about using a probe and then go on dissecting it is really
nice, I'll try reproducing it soon,

Thanks,

- Arnaldo
 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  .../Documentation/perf.data-file-format.txt   | 106 +++++++++++++++++-
>  1 file changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index b0152e1095c5..e3f78269e417 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -67,9 +67,113 @@ flags. These define the valid bits:
>  
>  	HEADER_RESERVED		= 0,	/* always cleared */
>  	HEADER_FIRST_FEATURE	= 1,
> +
>  	HEADER_TRACING_DATA	= 1,
>  
> -Describe me.
> +The header consists of several entries of variable length such as file
> +contents of several trace files like 'header_page', 'header_event'.
> +Also complete probe/<event-name>/format files are included.
> +The numbers in parenthesis are structure members refered to later in
> +the description and example.
> +
> +struct tracing_data {
> +	char birthday[3] = { 23, 8, 68 };	Eyecatcher
> +	char tracing[12] = "tracing0.6";	Type and version
> +	uint8_t bigendian;			Big or little endian platform
> +	uint8_t sizelong;			Size of long in bytes
> +	uint32_t pagesize:			Pagesize in bytes
> +	char hdr_page[12] = "header_page"	Name of file             (1)
> +	uint64_t hdr_page_size;			File size in bytes       (1a)
> +	char hdr_page_contents[hdr_page_size];	Contents of file         (1b)
> +	char hdr_event[13] = "header_event"	Name of file             (2)
> +	uint64_t hdr_event_size;		File size in bytes
> +	char hdr_page_contents[hdr_event_size];	Contents of file
> +	uint32_t ftrace_count;			Number of ftrace entries (3)
> +	struct {				Size and content of file
> +	    uint64_t file_size;
> +	    char file_content[file_size]
> +	} ftrace[ftrace_count]			ftrace_count array elements
> +	uint32_t event_types;			Number of event types    (4)
> +	struct {
> +	    char name[];			Name, null terminatedg   (5)
> +	    uint32_t count;			Number of probes         (6)
> +	    struct {
> +	       uint64_t file_size;					 (7)
> +	       char file_content[file_size];				 (8)
> +	    }[count];				Count always > 0 or omitted
> +	}[event_types];
> +	uint32_t proc_kallsyms_size;		Always zero
> +	uint64_t printk_file_size;		File size in bytes       (9)
> +	char printk_format[printk_file_size];	Contents of file
> +	uint64_t saved_cmdlines_size;		File size in bytes       (10)
> +	char saved_cmdlines[saved_cmdlines_size];	Contents of file
> +};
> +
> +The structure description is straight forward. It contains file name, size
> +and contents from
> +- /sys/kernel/debug/tracing/events/header_page (1, 1a, 1b)
> +and
> +- /sys/kernel/debug/tracing/events/header_event (2).
> +
> +This is followed by a variable length part of format files found in directory
> +/sys/kernel/debug/tracing//events/ftrace/*/format for events selected
> +by the perf record -e XXX commands. Note member 'ftrace_count' can be zero.
> +
> +Next are the number of probe types specified by the perf record -e XXXX
> +command (4). Each type has stored its name (5), which is a null terminated
> +string, and the number of probes (6) belonging to this type. For each
> +active probe follows the file size (7) and file contents (8) of that probe.
> +
> +Finally the file size and contents of two more files is saved:
> +- Size of /proc/kallsyms (always hard coded to zero and no file contents)
> +- /sys/kernel/debug/tracing/printk_formats (9)
> +- /sys/kernel/debug/tracing/saved_cmdlines (10)
> +
> +Example for the dynamic probes and trace points:
> +Consider these probes have been set up:
> + # ./perf probe -l
> +  probe:vfs_getname    (on getname_flags:72@fs/namei.c with pathname)
> +  probe:xxx            (on do_file_open_root:11@fs/namei.c)
> + #
> +and this command used for recording:
> + # ./perf record -e probe:vfs_getname -e probe:xxx \
> +	-e tcp:tcp_retransmit_skb -- touch /tmp/xxx
> +
> +This command line leads to two events in directory
> +   /sys/kernel/debug/tracing/events/probe/vfs_getname
> +   /sys/kernel/debug/tracing/events/probe/xxx
> +and a tracepoint in directory
> +   /sys/kernel/debug/tracing/events/tcp/tcp_retransmit_skb.
> +
> +This results in this event_count (5) layout in the perf.data:
> +using command:
> + # od -Ax -t x4z -v perf.data
> +
> +0011a0 00000000 00000270 726f6265 00000000  >.......probe....<
> +             ^^ (4)^^^'' ''(5)''' ''--(6)-
> +	     4: # of types --> 2
> +	     5: first one named 'probe'
> +	     6: 2 probes defined
> +0011b0 02000000 00000001 766e616d 653a2078  >........vname: x<
> +       --###### (7)##### ##
> +             7: first one 'named' xxx with format file size 0x176
> +0011c0 78780a49 443a2031 3138360a 666f726d  >xx.ID: 1186.form<
> +...
> +001320 45432d3e 5f5f7072 6f62655f 69700a00  >EC->__probe_ip..<
> +                                        ''
> +001330 00000000 0001e36e 616d653a 20766673  >.......name: vfs<
> +       ''(7)''' ''''''
> +              7: second one named 'vfs_getname' with format file size 0x1e3
> +001340 5f676574 6e616d65 0a49443a 20313138  >_getname.ID: 118<
> +...
> +001510 70617468 6e616d65 290a7463 70000000  >pathname).tcp...<
> +                             ''(5 )'--(6)-
> +001520 00010000 00000000 05696e61 6d653a20  >.........iname: <
> +       ----#### (7)##### ####
> +       5: second event type named 'tcp'
> +       6: 1 probe defined
> +       7: size of format file 0x568
> +001530 7463705f 72657472 616e736d 69745f73  >tcp_retransmit_s<
>  
>  	HEADER_BUILD_ID = 2,
>  
> -- 
> 2.23.0
> 

-- 

- Arnaldo
