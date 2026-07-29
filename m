Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BDC1624C0;
	Wed, 29 Jul 2026 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785283993; cv=none; b=EQEBCNwqHgOP3T5LEREp/VT33ZQvyeR4X0cqqxhLGWV3TBgLIuqYIkPgtnDNrQJPvtF2zd54W88Zo6YAZHOCMDyXdIpBx6EWHHR9pxXfslDRCGMYNO7V82XBCo1g5ec9O409ht2/b4lVgh1JwZwVLoOtbIzLFAfplZ8tJsoARdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785283993; c=relaxed/simple;
	bh=dx+It1RKihYaHGvjVw4ejCIMBTqAonGjYhYiOilzIEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeFRwMNfyPW89J4o3C30ijkemZbzarybLSs0GnHZj0Mtl1TBGNsDuQw63dTWxvUWurs/RTsoxRrISIjtNgykTsZuQK0uVBNAhkVvPuuYFEAWbgxXUyNRMuYQKCigGsTPM4TWgAvpKuoamQSpxEs8ipNIj8hLdvVJd3owABb6aYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A83FE1A0586;
	Wed, 29 Jul 2026 00:13:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 996136000F;
	Wed, 29 Jul 2026 00:13:00 +0000 (UTC)
Date: Tue, 28 Jul 2026 20:13:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anubhav Shelat <ashelat@redhat.com>
Cc: acme@kernel.org, peterz@infradead.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Fuad Tabba <tabba@google.com>, Christian Brauner <brauner@kernel.org>, Sean
 Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/5] tracefs: add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20260728201334.6ccb48da@gandalf.local.home>
In-Reply-To: <20260715135231.338535-4-ashelat@redhat.com>
References: <20260715135231.338535-2-ashelat@redhat.com>
	<20260715135231.338535-4-ashelat@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 996136000F
X-Stat-Signature: 4ah5bniwggguxfxkhaje5dftxbyy4dqy
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18BpmbsJhO3B5fZlBgIw+VFTfHJh0+mK7c=
X-HE-Tag: 1785283980-459614
X-HE-Meta: U2FsdGVkX19DG8I7/1c7N0Bbq0TvTLgtdT1730g7jlezIs379IrpqKMVoyAvPy+md0FnTj5pO1ihlJ/X1ts/lqj5aXTA/BzNl1zPtoThNdqUyBtRXgYdDCTUsZ9JLLb0KhiyOvHJ4XBIQn3GEm6eDxDBBfcqVVCQLcdZCaxSLhz/083cs8qhFy3qy9K9TfSmAybA+dz0ll+CJ4pjC199B69yZ29uMxE0FNEWLUTJ4IkxvCQt/uZ2+wqaasgCCoTQIqTqwzenRBsmeVzBNrTcVLDN7xK4LRBXUzsj2OUoMf8BpCNme9pGzKT2ODTapIty3lUWhngHxXc3wnQMItQwMdPia/QHX4le


BTW, the tracing subsystem always capitalizes the subject:

  tracefs: Add read-only eventfs filesystem at /sys/kernel/events

On Wed, 15 Jul 2026 09:52:23 -0400
Anubhav Shelat <ashelat@redhat.com> wrote:

> Introduce a new read-only pseudo-filesystem "eventfs" mounted at
> /sys/kernel/events that exposes trace event format and id files
> (mode 0444) to unprivileged users. This allows tools like perf to
> discover event formats without requiring access to the full
> tracefs/debugfs mount.
> 
> The eventfs filesystem reuses the existing eventfs_inode lazy-lookup
> infrastructure. A new set of super_operations
> (eventfs_ro_super_operations) shares the tracefs inode allocator so
> that eventfs_get_inode() and get_tracefs() work on the RO superblock.
> The superblock is manually initialized to ensure the root inode is
> allocated with tracefs_alloc_inode, allowing the root to serve
> directly as the events directory without another events subdirectory.
> 
> Each qualifying event gets a subsystem directory containing format
> and id files. The top-level events directory also exposes header_page
> and header_event. Similar to tracefs, a change will need to be made in
> systemd to mount this filesystem automatically.
> 
> Assisted-by: CLAUDE:claude-opus-4 Apogee
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>

Anyway, I didn't like the way this patch duplicated the eventfs_inodes as
that just wastes memory. It duplicates all the events for just making them
have some read only files to show. So I took another approach.

I started with this patch and then changed it to instead have two look up
functions. One normal, and one for the read only file system.

It adds a "read_only" field to the eventfs_entry (which is just what
describes what files to print for every event). For the fields we want to
show to the normal user, the "read_only" field is set to true.

Then when the /sys/kernel/events directory is read, it uses the "read_only"
version of the look up and it will only show the events that are marked as
"read_only". It also changes the mode to allow normal users to read the
files.

I replaced the eventfs_create_events_dir_ro() with eventfs_create_events_ro_copy().
It takes a name and an eventfs_inode to use to copy as the "read_only" version.

Below is the patch I used to replace this one. Feel free to start with it,
clean it up a bit, and resubmit a v6.

Thanks!

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..007cdf1a67f3 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -151,7 +151,11 @@ static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
+static struct dentry *eventfs_root_lookup_ro(struct inode *dir,
+					     struct dentry *dentry,
+					     unsigned int flags);
 static int eventfs_iterate(struct file *file, struct dir_context *ctx);
+static int eventfs_ro_iterate(struct file *file, struct dir_context *ctx);
 
 static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
 {
@@ -229,6 +233,10 @@ static const struct inode_operations eventfs_dir_inode_operations = {
 	.setattr	= eventfs_set_attr,
 };
 
+static const struct inode_operations eventfs_ro_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup_ro,
+};
+
 static const struct inode_operations eventfs_file_inode_operations = {
 	.setattr	= eventfs_set_attr,
 };
@@ -239,6 +247,12 @@ static const struct file_operations eventfs_file_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+static const struct file_operations eventfs_ro_file_operations = {
+	.read		= generic_read_dir,
+	.iterate_shared	= eventfs_ro_iterate,
+	.llseek		= generic_file_llseek,
+};
+
 static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t uid,
 			      bool update_gid, kgid_t gid, int level)
 {
@@ -402,7 +416,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
  * a eventfs_inode.
  */
 static struct dentry *lookup_dir_entry(struct dentry *dentry,
-	struct eventfs_inode *pei, struct eventfs_inode *ei)
+	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
 {
 	struct inode *inode;
 	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -411,8 +425,13 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 
-	inode->i_op = &eventfs_dir_inode_operations;
-	inode->i_fop = &eventfs_file_operations;
+	if (ro) {
+		inode->i_op = &eventfs_ro_dir_inode_operations;
+		inode->i_fop = &eventfs_ro_file_operations;
+	} else {
+		inode->i_op = &eventfs_dir_inode_operations;
+		inode->i_fop = &eventfs_file_operations;
+	}
 
 	/* All directories will have the same inode number */
 	inode->i_ino = eventfs_dir_ino(ei);
@@ -514,9 +533,10 @@ lookup_file_dentry(struct dentry *dentry,
  * list, if @dentry found go ahead and create the file/dir
  */
 
-static struct dentry *eventfs_root_lookup(struct inode *dir,
-					  struct dentry *dentry,
-					  unsigned int flags)
+static struct dentry *__eventfs_root_lookup(struct inode *dir,
+					    struct dentry *dentry,
+					    unsigned int flags,
+					    bool ro)
 {
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
@@ -539,7 +559,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		/* A child is freed and removed from the list at the same time */
 		if (WARN_ON_ONCE(ei_child->is_freed))
 			return NULL;
-		return lookup_dir_entry(dentry, ei, ei_child);
+		return lookup_dir_entry(dentry, ei, ei_child, ro);
 	}
 
 	for (int i = 0; i < ei->nr_entries; i++) {
@@ -551,20 +571,40 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(name, entry->name) != 0)
 			continue;
 
+		if (ro && !entry->read_only)
+			return NULL;
+
 		data = ei->data;
 		if (entry->callback(name, &mode, &data, &fops) <= 0)
 			return NULL;
 
+		if (ro)
+			mode |= 0444;
+
 		return lookup_file_dentry(dentry, ei, i, mode, data, fops);
 
 	}
 	return NULL;
 }
 
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags)
+{
+	return __eventfs_root_lookup(dir, dentry, flags, false);
+}
+
+static struct dentry *eventfs_root_lookup_ro(struct inode *dir,
+					     struct dentry *dentry,
+					     unsigned int flags)
+{
+	return __eventfs_root_lookup(dir, dentry, flags, true);
+}
+
 /*
  * Walk the children of a eventfs_inode to fill in getdents().
  */
-static int eventfs_iterate(struct file *file, struct dir_context *ctx)
+static int __eventfs_iterate(struct file *file, struct dir_context *ctx, bool ro)
 {
 	const struct file_operations *fops;
 	struct inode *f_inode = file_inode(file);
@@ -606,6 +646,9 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		entry = &ei->entries[i];
 		name = entry->name;
 
+		if (ro && !entry->read_only)
+			continue;
+
 		/* If ei->is_freed then just bail here, nothing more to do */
 		scoped_guard(mutex, &eventfs_mutex) {
 			if (ei->is_freed)
@@ -650,6 +693,16 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	return 1;
 }
 
+static int eventfs_iterate(struct file *file, struct dir_context *ctx)
+{
+	return __eventfs_iterate(file, ctx, false);
+}
+
+static int eventfs_ro_iterate(struct file *file, struct dir_context *ctx)
+{
+	return __eventfs_iterate(file, ctx, true);
+}
+
 /**
  * eventfs_create_dir - Create the eventfs_inode for this directory
  * @name: The name of the directory to create.
@@ -812,6 +865,47 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ERR_PTR(-ENOMEM);
 }
 
+/**
+ * eventfs_create_events_dir_ro - create a read-only events directory
+ * @name: The name of the top level directory to create.
+ * @entries: A list of entries that represent the files under this directory
+ * @size: The number of @entries
+ * @data: The default data to pass to the files (an entry may override it).
+ *
+ * This function configures the eventfs filesystem root as a read-only
+ * trace event directory using the existing eventfs_inode lazy-lookup
+ * infrastructure.
+ *
+ * See eventfs_create_dir() for use of @entries.
+ */
+int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei)
+{
+	struct dentry *dentry;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	dentry = eventfs_ro_get_root();
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	inode = d_inode(dentry);
+
+	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->private = ei;
+
+	inode->i_op = &eventfs_ro_dir_inode_operations;
+	inode->i_fop = &eventfs_ro_file_operations;
+
+	/* This is never freed */
+	dentry->d_fsdata = get_ei(ei);
+
+	return 0;
+}
+
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index f3d6188a3b7b..fd064d79d940 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -30,6 +30,9 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static struct vfsmount *eventfs_ro_mount;
+static int eventfs_ro_mount_count;
+
 /*
  * Keep track of all tracefs_inodes in order to update their
  * flags if necessary on a remount.
@@ -423,6 +426,14 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
+static const struct super_operations eventfs_ro_super_operations = {
+	.alloc_inode    = tracefs_alloc_inode,
+	.free_inode     = tracefs_free_inode,
+	.destroy_inode  = tracefs_destroy_inode,
+	.drop_inode     = tracefs_drop_inode,
+	.statfs		= simple_statfs,
+};
+
 /*
  * It would be cleaner if eventfs had its own dentry ops.
  *
@@ -523,6 +534,79 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
+static int eventfs_ro_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+	sb->s_magic = EVENTFS_SUPER_MAGIC;
+	sb->s_op = &eventfs_ro_super_operations;
+	sb->s_time_gran = 1;
+	sb->s_flags |= SB_RDONLY;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = 1;
+	inode->i_mode = S_IFDIR | 0555;
+	simple_inode_init_ts(inode);
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	set_nlink(inode, 2);
+
+	set_default_d_op(sb, &tracefs_dentry_operations);
+
+	root = d_make_root(inode);
+	if (!root)
+		return -ENOMEM;
+
+	sb->s_root = root;
+
+	return 0;
+}
+
+static int eventfs_ro_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, eventfs_ro_fill_super);
+}
+
+static const struct fs_context_operations eventfs_ro_context_ops = {
+	.get_tree	= eventfs_ro_get_tree,
+};
+
+static int eventfs_ro_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &eventfs_ro_context_ops;
+	return 0;
+}
+
+static struct file_system_type eventfs_ro_fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"eventfs",
+	.init_fs_context = eventfs_ro_init_fs_context,
+	.kill_sb =	kill_anon_super,
+};
+
+struct dentry *eventfs_ro_get_root(void)
+{
+	int error;
+
+	error = simple_pin_fs(&eventfs_ro_fs_type, &eventfs_ro_mount,
+			      &eventfs_ro_mount_count);
+	if (error)
+		return ERR_PTR(error);
+
+	return dget(eventfs_ro_mount->mnt_root);
+}
+
+void eventfs_ro_put_root(void)
+{
+	simple_release_fs(&eventfs_ro_mount, &eventfs_ro_mount_count);
+}
+
 struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
@@ -801,8 +885,15 @@ static int __init tracefs_init(void)
 		return -EINVAL;
 
 	retval = register_filesystem(&trace_fs_type);
-	if (!retval)
-		tracefs_registered = true;
+	if (retval)
+		return retval;
+	tracefs_registered = true;
+
+	retval = sysfs_create_mount_point(kernel_kobj, "events");
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&eventfs_ro_fs_type);
 
 	return retval;
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index a4a7f8431aff..0440413f959b 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -73,6 +73,9 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
 
+struct dentry *eventfs_ro_get_root(void);
+void eventfs_ro_put_root(void);
+
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index bc354d340046..41e97a6bd69a 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -75,6 +75,7 @@ struct eventfs_entry {
 	const char			*name;
 	eventfs_callback		callback;
 	eventfs_release			release;
+	bool				read_only;
 };
 
 struct eventfs_inode;
@@ -87,6 +88,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 					 const struct eventfs_entry *entries,
 					 int size, void *data);
 
+int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei);
+
 void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
 
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76c..7cf8f1a1ae38 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -75,6 +75,7 @@
 #define STACK_END_MAGIC		0x57AC6E9D
 
 #define TRACEFS_MAGIC          0x74726163
+#define EVENTFS_SUPER_MAGIC    0x65766673
 
 #define V9FS_MAGIC		0x01021997
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9874ad524aa7..ab14b4b6e70f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3235,17 +3235,20 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "format",
 			.callback	= event_callback,
+			.read_only	= true,
 		},
 #ifdef CONFIG_PERF_EVENTS
 		{
 			.name		= "id",
 			.callback	= event_callback,
+			.read_only	= true,
 		},
 #endif
 #ifdef CONFIG_BPF_EVENTS
 		{
 			.name		= "btf_ids",
 			.callback	= event_callback,
+			.read_only	= true,
 		},
 #endif
 #define NR_RO_EVENT_ENTRIES	(1 + IS_ENABLED(CONFIG_PERF_EVENTS) + \
@@ -4652,6 +4655,7 @@ static int events_callback(const char *name, umode_t *mode, void **data,
 static int
 create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
+	static bool event_dir_ro_created;
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
 	int nr_entries;
@@ -4659,10 +4663,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		{
 			.name		= "header_page",
 			.callback	= events_callback,
+			.read_only	= true,
 		},
 		{
 			.name		= "header_event",
 			.callback	= events_callback,
+			.read_only	= true,
 		},
 #define NR_RO_TOP_ENTRIES	2
 /* Readonly files must be above this line and counted by NR_RO_TOP_ENTRIES. */
@@ -4705,6 +4711,13 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	tr->event_dir = e_events;
 
+	if (!event_dir_ro_created && (tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
+		int ret;
+
+		ret = eventfs_create_events_ro_copy("events", e_events);
+		if (!ret)
+			event_dir_ro_created = true;
+	}
 	return 0;
 }
 
